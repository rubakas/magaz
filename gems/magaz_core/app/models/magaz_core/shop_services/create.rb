module MagazCore
  module ShopServices
    class Create
      include MagazCore::Concerns::Service
      attr_accessor :shop

      def call(shop_params: {})
        @shop          = MagazCore::Shop.new
        @default_theme = MagazCore::Theme.new(name: "Theme")
        archive_path = ::File.expand_path("#{Rails.root}/test/fixtures/files/valid_theme.zip", __FILE__)
        MagazCore::ThemeServices::ImportFromArchive
          .call(archive_path: archive_path,
              theme: @default_theme,
              theme_attributes: { name: 'Default' })

        MagazCore::Shop.connection.transaction do
          begin
            _save_shop_record!(shop: @shop, params: shop_params)
            _install_default_theme(shop: @shop)
            _create_default_blogs_and_posts!(shop: @shop)
            _create_default_collection!(shop: @shop)
            _create_default_pages!(shop: @shop)

            # links created after linked content, right? :)
            _create_default_link_lists!(shop: @shop)
          rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid
            raise ActiveRecord::Rollback
          end
        end
      end

      private

      def _save_shop_record!(shop:, params:)
        shop.attributes = params
        shop.save!
      end

      def _install_default_theme(shop:)
        # Default theme, fail unless found
        default_theme = MagazCore::Theme.sources.first || fail(ActiveRecord::RecordNotFound)
        MagazCore::ThemeServices::Install
          .call(shop_id: shop.id, source_theme_id: default_theme.id)
      end

      def _create_default_blogs_and_posts!(shop:)
        default_blog = shop
          .blogs
          .create title: MagazCore::Blog::DEFAULT_BLOG_TITLE #Comments are disabled

        default_post = default_blog
          .articles
          .create title:    MagazCore::Article::DEFAULT_ARTICLE_TITLE,
                  content:  MagazCore::Article::DEFAULT_ARTICLE_CONTENT
      end

      def _create_default_collection!(shop:)
        shop
          .collections
          .create name:         MagazCore::Collection::DEFAULT_COLLECTION_NAME,
                  description:  MagazCore::Collection::DEFAULT_COLLECTION_DESCRIPTION
      end

      def _create_default_link_lists!(shop:)
        #Main Menu link list
        default_menu_link_list = shop
          .link_lists
          .create name:         MagazCore::LinkList::DEFAULT_MENU_LINK_LIST_NAME

        #Links for Main Menu
        default_home_link = default_menu_link_list
          .links
          .create name:         MagazCore::Link::DEFAULT_HOME_LINK_NAME

        default_blog_link = default_menu_link_list
          .links
          .create name:         MagazCore::Link::DEFAULT_BLOG_LINK_NAME

        #Footer link list
        default_footer_link_list = shop
          .link_lists
          .create name:         MagazCore::LinkList::DEFAULT_FOOTER_LINK_LIST_NAME

        #Links for Footer
        default_search_link = default_footer_link_list
          .links
          .create name:         MagazCore::Link::DEFAULT_SEARCH_LINK_NAME

        default_about_link = default_footer_link_list
          .links
          .create name:         MagazCore::Link::DEFAULT_ABOUT_LINK_NAME
      end

      def _create_default_pages!(shop:)
        shop
          .pages
          .create title:        MagazCore::Page::DEFAULT_ABOUT_US_TITLE,
                  content:      MagazCore::Page::DEFAULT_ABOUT_US_CONTENT,
                  publish_on:   nil,
                  published_at: nil

        shop
          .pages
          .create title:        MagazCore::Page::DEFAULT_WELCOME_TITLE,
                  content:      MagazCore::Page::DEFAULT_WELCOME_CONTENT,
                  publish_on:   nil,
                  published_at: nil
      end

    end
  end
end