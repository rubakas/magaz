class StoreServices::Create < ActiveInteraction::Base

  string :shop_name, :first_name, :last_name, :email, :password

  validates :shop_name, :email, :password, :first_name, :last_name, presence: true

  validate :shop_name_uniqueness

  def to_model
    Shop.new
  end

  def execute
    @shop = Shop.new

    Shop.connection.transaction do
      begin
        @shop.attributes = {name: shop_name}
        @shop.save!
        @user = AdminServices::User::AddUser.new(shop_id: @shop.id, params: user_params).run.result
        _install_default_theme(shop_id: @shop.id)
        _create_default_blogs_and_posts!(shop_id: @shop.id)

        # create default collection
        AdminServices::Collection::AddCollection.new(shop_id: @shop.id, params: collection_params).run

        # create default pages
        AdminServices::Page::AddPage.new(shop_id: @shop.id, params: about_page_params).run
        AdminServices::Page::AddPage.new(shop_id: @shop.id, params: welcome_page_params).run

        # links created after linked content, right? :)
        _create_default_link_lists!(shop_id: @shop.id)
        _create_default_emails!(shop: @shop)

        raise RuntimeError.new() unless self.errors.blank?
      rescue RuntimeError, ActiveRecord::RecordInvalid
        raise ActiveRecord::Rollback
      end
    end

    {shop: @shop, user: @user}
  end

  private

  def shop_name_uniqueness
    errors.add(:base, I18n.t('services.create.name_not_unique')) unless shop_name_unique?
  end

  def shop_name_unique?
    Shop.where(name: shop_name).count == 0
  end

  def _install_default_theme(shop_id:)
    # Default theme, fail unless found
    if Theme.sources.first
      ThemeServices::InstallTheme.new(shop_id: shop_id, source_theme_id: Theme.sources.first.id).run
    else
      errors.add(:base, I18n.t('services.create.no_default_theme'))
      fail 'No default theme in system'
    end
  end

  def _create_default_blogs_and_posts!(shop_id:)
    default_blog = AdminServices::Blog::AddBlog
                     .new(shop_id: shop_id, params: { title: I18n.t('default.models.blog.blog_title') })
                     .run
                     .result


    AdminServices::Article::AddArticle
    .new(blog_id: default_blog.id,
         params: {
                   title: I18n.t('default.models.article.article_title'),
                   content: I18n.t('default.models.article.article_content')
                 }
        )
    .run
  end

  def _create_default_link_lists!(shop_id:)
    #Main Menu link list
    default_menu_link_list = AdminServices::LinkList::AddLinkList
                               .new(shop_id: shop_id, params: { name: I18n.t('default.models.link_list.menu_link_list_name') })
                               .run
                               .result

    #Links for Main Menu
    AdminServices::Link::AddLink
      .new(link_list_id: default_menu_link_list.id, params: { name: I18n.t('default.models.link.home_link_name') })
      .run

    AdminServices::Link::AddLink
      .new(link_list_id: default_menu_link_list.id, params: { name: I18n.t('default.models.link.blog_link_name') })
      .run

    #Footer link list
    default_footer_link_list = AdminServices::LinkList::AddLinkList
                                 .new(shop_id: shop_id, params: { name: I18n.t('default.models.link_list.footer_link_list_name') })
                                 .run
                                 .result

    #Links for Footer
    AdminServices::Link::AddLink
      .new(link_list_id: default_footer_link_list.id, params: { name: I18n.t('default.models.link.search_link_name') })
      .run

    AdminServices::Link::AddLink
        .new(link_list_id: default_footer_link_list.id, params: { name: I18n.t('default.models.link.about_link_name') })
        .run
  end

  def _create_default_emails!(shop:)
    EmailTemplate::EMAIL_TEMPLATES.each do |template_type|
      @shop.email_templates.create(template_type: template_type,
                                   name:          I18n.t("default.models.email_templates.#{template_type}.name"),
                                   title:         I18n.t("default.models.email_templates.#{template_type}.title"),
                                   body:          I18n.t("default.models.email_templates.#{template_type}.body"),
                                   description:   I18n.t("default.models.email_templates.#{template_type}.description"))
    end
  end

  def user_params
    {
      email: email,
      password: password,
      account_owner: true,
      first_name: first_name,
      last_name: last_name,
      permissions: nil
    }
  end

  def about_page_params
    {
      title: I18n.t('default.models.page.about_title'),
      content: I18n.t('default.models.page.about_content'),
    }
  end

  def welcome_page_params
    {
      title: I18n.t('default.models.page.welcome_title'),
      content: I18n.t('default.models.page.welcome_content')
    }
  end

  def collection_params
    { handle: '',
      name: I18n.t('default.models.collection.collection_title'),
      page_title: '',
      description: I18n.t('default.models.collection.collection_description'),
      meta_description: ''
    }
  end
end
