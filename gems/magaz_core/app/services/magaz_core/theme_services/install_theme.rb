module MagazCore
  module ThemeServices
    class InstallTheme < ActiveInteraction::Base

      integer :shop_id, :source_theme_id
      #integer :source_theme_id, default: nil

      validates :shop_id, :source_theme_id, presence: true

      validate :default_theme_exists?

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

      def default_theme_exists?
        if MagazCore::Theme.find_by_id(source_theme_id)
          return true
        else
          errors.add(:base, I18n.t('default.services.install_theme.no_default_theme'))
          return false
        end
      end

    end
  end
end
