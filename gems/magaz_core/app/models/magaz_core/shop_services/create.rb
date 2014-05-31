module MagazCore
  module ShopServices
    class Create
      include MagazCore::Concerns::Service
      attr_accessor :shop

      def call(shop_params: {})
        @shop          = MagazCore::Shop.new

        MagazCore::Shop.connection.transaction do
          begin
            _create_shop_record!(shop: @shop, params: shop_params)
            _install_default_theme(shop: @shop)
            _create_default_pages
          rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid
            raise ActiveRecord::Rollback
          end
        end
      end

      private

      def _create_shop_record!(shop:, params:)
        shop.attributes = params
        shop.save!
      end

      def _install_default_theme(shop:)
        #TODO: implement default theme, rails unless found
        default_theme = MagazCore::Theme.sources.first || fail(ActiveRecord::RecordNotFound)
        MagazCore::ThemeServices::Install
          .call(shop_id: shop.id, source_theme_id: default_theme.id)
      end

      def _create_default_pages
        #TODO: create default pages - not published
      end

    end
  end
end