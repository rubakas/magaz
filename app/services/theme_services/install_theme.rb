module MagazCore
  module ThemeServices
    class InstallTheme < ActiveInteraction::Base

      integer :shop_id, :source_theme_id

      validates :shop_id, :source_theme_id, presence: true

      validate :shop_exists?

      def execute
        shop          = MagazCore::Shop.find(shop_id)
        source_theme  = MagazCore::Theme.find(source_theme_id)

        #TODO: process payment
        # copy theme data and associate with shop

        installed_theme = shop.themes.build(name: source_theme.name,
                                            source_theme: source_theme)

        source_theme.assets.each do |source_asset|
          installed_theme
            .assets
            .build(source_asset.attributes.reject { |k| 'id' == k.to_s })
        end

        installed_theme.save!

        installed_theme
      end

      private

      def shop_exists?
        if MagazCore::Shop.find_by_id(shop_id)
          return true
        else
          errors.add(:base, I18n.t('services.install_theme.invalid_shop_id'))
          return false
        end
      end

    end
  end
end
