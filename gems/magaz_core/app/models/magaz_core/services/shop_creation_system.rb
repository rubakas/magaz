module MagazCore
  module Services
    class ShopCreationSystem
      attr_reader :shop

      def initialize()
        @shop          = MagazCore::Shop.new
        @default_theme = MagazCore::Theme.sources.first #TODO implement default theme
      end

      def create(shop_params)
        MagazCore::Shop.connection.transaction do
          begin
            @shop.attributes = shop_params
            @shop.save!
            MagazCore::Services::ThemeSystem.new(shop_id: @shop.id, source_theme_id: @default_theme.id)
              .install_theme
          rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid
            raise ActiveRecord::Rollback
          end
        end
      end
    end
  end
end