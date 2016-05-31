class StoreServices::Create < ActiveInteraction::Base

  string :shop_name, :first_name, :last_name, :email, :password

  validates :shop_name, :email, :password, :first_name, :last_name, presence: true

  validate :shop_name_uniqueness

  def to_model
    Shop.new
  end


  def execute
    @shop = Shop.new
    @user = User.new

    Shop.connection.transaction do
      begin
        @shop.attributes = {name: shop_name}
        @shop.save!

        @user = compose(AdminServices::User::AddUser,
                        email: email,
                        password: password,
                        account_owner: true,
                        shop_id: @shop.id,
                        first_name: first_name,
                        last_name: last_name,
                        permissions: nil)

        _install_default_theme(shop_id: @shop.id)
        _create_default_blogs_and_posts!(shop_id: @shop.id)

        # create default collection
        compose(AdminServices::Collection::AddCollection,
                handle: '',
                name: I18n.t('default.models.collection.collection_title'),
                page_title: '',
                description: I18n.t('default.models.collection.collection_description'),
                shop_id: @shop.id,
                meta_description: '')

        # create default pages
        compose(AdminServices::Page::AddPage,
                shop_id: @shop.id,
                title: I18n.t('default.models.page.about_title'),
                page_title: '',
                content: I18n.t('default.models.page.about_content'),
                handle: '',
                meta_description: '',
                publish_on: nil,
                published_at: nil)

        compose(AdminServices::Page::AddPage,
                shop_id: @shop.id,
                title: I18n.t('default.models.page.welcome_title'),
                page_title: '',
                content: I18n.t('default.models.page.welcome_content'),
                handle: '',
                meta_description: '',
                publish_on: nil,
                published_at: nil)

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
      compose(ThemeServices::InstallTheme,
              shop_id: shop_id,
              source_theme_id: Theme.sources.first.id)
    else
      errors.add(:base, I18n.t('services.create.no_default_theme'))
      fail 'No default theme in system'
    end
  end

  def _create_default_blogs_and_posts!(shop_id:)
    default_blog = compose(AdminServices::Blog::AddBlog,
                           meta_description: '',
                           title: I18n.t('default.models.blog.blog_title'),
                           handle: '',
                           shop_id: shop_id,
                           page_title: '')


    compose(AdminServices::Article::AddArticle,
            handle: '',
            title: I18n.t('default.models.article.article_title'),
            page_title: '',
            content: I18n.t('default.models.article.article_content'),
            meta_description: '',
            blog_id: default_blog.id)
  end

  def _create_default_link_lists!(shop_id:)
    #Main Menu link list
    default_menu_link_list = compose(AdminServices::LinkList::AddLinkList,
                                     shop_id: shop_id,
                                     name: I18n.t('default.models.link_list.menu_link_list_name'),
                                     handle: '')

    #Links for Main Menu
    compose(AdminServices::Link::AddLink,
            position: '',
            name: I18n.t('default.models.link.home_link_name'),
            link_type: '',
            link_list_id: "#{default_menu_link_list.id}")

    compose(AdminServices::Link::AddLink,
            position: '',
            name: I18n.t('default.models.link.blog_link_name'),
            link_type: '',
            link_list_id: "#{default_menu_link_list.id}")

    #Footer link list
    default_footer_link_list = compose(AdminServices::LinkList::AddLinkList,
                                       shop_id: shop_id,
                                       name: I18n.t('default.models.link_list.footer_link_list_name'),
                                       handle: '')

    #Links for Footer
    compose(AdminServices::Link::AddLink,
            position: '',
            name: I18n.t('default.models.link.search_link_name'),
            link_type: '',
            link_list_id: "#{default_footer_link_list.id}")

    compose(AdminServices::Link::AddLink,
            position: '',
            name: I18n.t('default.models.link.about_link_name'),
            link_type: '',
            link_list_id: "#{default_footer_link_list.id}")
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
end
