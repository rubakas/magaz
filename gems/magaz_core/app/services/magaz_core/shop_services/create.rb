module MagazCore
  module ShopServices
    class Create
      include MagazCore::Concerns::Service
      attr_accessor :shop
      attr_accessor :user

      def call(shop_params: {}, user_params: {})
        @shop = MagazCore::Shop.new
        @user = MagazCore::User.new

        MagazCore::Shop.connection.transaction do
          begin
            @shop.attributes = shop_params
            @shop.save!
            @user.attributes = user_params.merge(account_owner: true, shop_id: @shop.id)
            @user.save!
            _install_default_theme(shop: @shop)
            _create_default_blogs_and_posts!(shop: @shop)
            _create_default_collection!(shop: @shop)
            _create_default_pages!(shop: @shop)
            # links created after linked content, right? :)
            _create_default_link_lists!(shop: @shop)
            _create_default_emails!(shop: @shop)
          rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid
            raise ActiveRecord::Rollback
          end
        end
      end

      private

      def _install_default_theme(shop:)
        # Default theme, fail unless found
        default_theme = MagazCore::Theme.sources.first || fail(ActiveRecord::RecordNotFound)
        MagazCore::ThemeServices::Install
          .call(shop_id: shop.id, source_theme_id: default_theme.id)
      end

      def _create_default_blogs_and_posts!(shop:)
        default_blog = shop
          .blogs
          .create title: I18n.t('default.models.blog.blog_title') #Comments are disabled

        default_post = default_blog
          .articles
          .create title:    I18n.t('default.models.article.article_title'),
                  content:  I18n.t('default.models.article.article_content')
      end

      def _create_default_collection!(shop:)
        shop
          .collections
          .create name:         I18n.t('default.models.collection.collection_title'),
                  description:  I18n.t('default.models.collection.collection_description')
      end

      def _create_default_link_lists!(shop:)
        #Main Menu link list
        link_list_service = MagazCore::ShopServices::AddLinkList.run(name: I18n.t('default.models.link_list.menu_link_list_name'),
                                                                     handle: '',
                                                                     shop_id: shop.id)
        default_menu_link_list = link_list_service.result

        #Links for Main Menu
        default_home_link = default_menu_link_list
          .links
          .create name:         I18n.t('default.models.link.home_link_name')

        default_blog_link = default_menu_link_list
          .links
          .create name:         I18n.t('default.models.link.blog_link_name')

        #Footer link list
        default_footer_link_list = shop
          .link_lists
          .create name:         I18n.t('default.models.link_list.footer_link_list_name')

        #Links for Footer
        default_search_link = default_footer_link_list
          .links
          .create name:         I18n.t('default.models.link.search_link_name')

        default_about_link = default_footer_link_list
          .links
          .create name:         I18n.t('default.models.link.about_link_name')
      end

      def _create_default_pages!(shop:)
        shop
          .pages
          .create title:        I18n.t('default.models.page.about_title'),
                  content:      I18n.t('default.models.page.about_content'),
                  publish_on:   nil,
                  published_at: nil

        shop
          .pages
          .create title:        I18n.t('default.models.page.welcome_title'),
                  content:      I18n.t('default.models.page.welcome_content'),
                  publish_on:   nil,
                  published_at: nil
      end

      def _create_default_emails!(shop:)
        MagazCore::EmailTemplate::EMAIL_TEMPLATES.each do |template_type|
          shop.email_templates.create(template_type: template_type,
                                      name:          I18n.t("email_templates.#{template_type}.name"),
                                      title:         I18n.t("email_templates.#{template_type}.title"),
                                      body:          I18n.t("email_templates.#{template_type}.body"),
                                      description:   I18n.t("email_templates.#{template_type}.description"))
        end
      end
    end
  end
end