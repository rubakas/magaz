class StoreServices::Create

  attr_reader :success, :errors, :result
  alias_method :success?, :success

  def initialize params:
    @shop = Shop.new
    @params = params
    @success = true
    @errors = []
  end

  def run
    Shop.connection.transaction do
      begin
        _create_shop!
        _create_user!(shop_id: @shop.id)
        _install_default_theme(shop_id: @shop.id)
        _create_default_blogs_and_posts!(shop_id: @shop.id)
        _create_default_collection!(shop_id: @shop.id)
        _create_default_pages!(shop_id: @shop.id)

        # links created after linked content, right? :)
        _create_default_link_lists!(shop_id: @shop.id)
        _create_default_emails!

        check_errors
      rescue RuntimeError, ActiveRecord::RecordInvalid
        @success = false
        raise ActiveRecord::Rollback
      end
    end
    @result = { shop: @shop, user: @user }
    self
  end

  private

  def _install_default_theme(shop_id:)
    # Default theme, fail unless found
    if Theme.sources.first
      theme = ThemeServices::InstallTheme
              .new(shop_id: shop_id, source_theme_id: Theme.sources.first.id)
              .run
              .result
      collect_errors(theme)
    else
      @errors << I18n.t('services.create.no_default_theme')
      fail 'No default theme in system'
    end
  end

  def _create_default_blogs_and_posts!(shop_id:)
    default_blog = AdminServices::Blog::AddBlog
                   .new(shop_id: shop_id, params: { 'title' => I18n.t('default.models.blog.blog_title') })
                   .run
                   .result
    collect_errors(default_blog)

    article = AdminServices::Article::AddArticle
              .new(blog_id: default_blog.id, params: article_params)
              .run
              .result
    collect_errors(article)
  end

  def _create_default_link_lists!(shop_id:)
    #Main Menu link list
    default_menu_link_list = AdminServices::LinkList::AddLinkList
                             .new(shop_id: shop_id, params: { 'name' => I18n.t('default.models.link_list.menu_link_list_name') })
                             .run
                             .result
    collect_errors(default_menu_link_list)
    #Links for Main Menu
    home_link = AdminServices::Link::AddLink
                .new(link_list_id: default_menu_link_list.id, params: { 'name' => I18n.t('default.models.link.home_link_name') })
                .run
                .result
    collect_errors(home_link)

    blog_link = AdminServices::Link::AddLink
                .new(link_list_id: default_menu_link_list.id, params: { 'name' => I18n.t('default.models.link.blog_link_name') })
                .run
                .result
    collect_errors(blog_link)

    #Footer link list
    default_footer_link_list = AdminServices::LinkList::AddLinkList
                               .new(shop_id: shop_id, params: { 'name' => I18n.t('default.models.link_list.footer_link_list_name') })
                               .run
                               .result
    collect_errors(default_footer_link_list)

    #Links for Footer
    search_link = AdminServices::Link::AddLink
                  .new(link_list_id: default_footer_link_list.id, params: { 'name' => I18n.t('default.models.link.search_link_name') })
                  .run
                  .result
    collect_errors(search_link)

    about_link = AdminServices::Link::AddLink
                 .new(link_list_id: default_footer_link_list.id, params: { 'name' => I18n.t('default.models.link.about_link_name') })
                 .run
                 .result
    collect_errors(about_link)
  end

  def _create_default_emails!
    EmailTemplate::EMAIL_TEMPLATES.each do |template_type|
      @shop.email_templates.create(template_type: template_type,
                                   name:          I18n.t("default.models.email_templates.#{template_type}.name"),
                                   title:         I18n.t("default.models.email_templates.#{template_type}.title"),
                                   body:          I18n.t("default.models.email_templates.#{template_type}.body"),
                                   description:   I18n.t("default.models.email_templates.#{template_type}.description"))
    end
  end

  def _create_shop!
    @shop.attributes = shop_params
    @shop.save
    collect_errors(@shop)
    check_errors
  end

  def _create_user!(shop_id:)
    @user = AdminServices::User::AddUser
                .new(shop_id: shop_id, params: user_params)
                .run
                .result
    collect_errors(@user)
  end

  def _create_default_collection!(shop_id:)
    collection = AdminServices::Collection::AddCollection
                .new(shop_id: shop_id, params: collection_params)
                .run
                .result
    collect_errors(collection)
  end

  def _create_default_pages!(shop_id:)
    about_page =   AdminServices::Page::AddPage
                   .new(shop_id: shop_id, params: about_page_params)
                   .run
                   .result

    collect_errors(about_page)
    welcome_page = AdminServices::Page::AddPage
                   .new(shop_id: shop_id, params: welcome_page_params)
                   .run
                   .result
    collect_errors(welcome_page)
  end

  def shop_params
    {
      'name' => @params['name'],
      'all_taxes_are_included' => true,
      'charge_taxes_on_shipping_rates' => false
    }
  end

  def user_params
    {
      'email'       => @params['email'],
      'password'    => @params['password'],
      'account_owner' => true,
      'first_name'  =>   @params['first_name'],
      'last_name'   =>    @params['last_name'],
      'permissions' => nil
    }
  end

  def about_page_params
    {
      'title' => I18n.t('default.models.page.about_title'),
      'content' => I18n.t('default.models.page.about_content'),
    }
  end

  def welcome_page_params
    {
      'title' => I18n.t('default.models.page.welcome_title'),
      'content' => I18n.t('default.models.page.welcome_content')
    }
  end

  def collection_params
    {
      'handle'           => '',
      'name'             => I18n.t('default.models.collection.collection_title'),
      'page_title'       => '',
      'description'      => I18n.t('default.models.collection.collection_description'),
      'meta_description' => ''
    }
  end

  def article_params
    {
      'title'   => I18n.t('default.models.article.article_title'),
      'content' => I18n.t('default.models.article.article_content')
    }
  end

  def collect_errors(object)
    @errors += object.errors.full_messages if object.errors.present?
  end

  def check_errors
    raise RuntimeError.new() unless @errors.blank?
  end
end
