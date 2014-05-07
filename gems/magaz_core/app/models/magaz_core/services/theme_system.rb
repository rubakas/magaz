module MagazCore
  class Services::ThemeSystem
    attr_reader :shop, :source_theme, :installed_theme

    def initialize(shop_id:, source_theme_id: nil, installed_theme_id: nil)
      @shop          = Shop.find(shop_id)
      @source_theme  = Theme.find(source_theme_id) unless source_theme_id.nil?
      @installed_theme = Theme.find(installed_theme_id) unless installed_theme_id.nil?
    end

    def install_theme
      #TODO: process payment
      # copy theme data and associate with shop
      @installed_theme = 
        @shop.themes.create!(name: @source_theme.name, source_theme: @source_theme)
      # start copying process and move assets to CDN?
    end

    def activate_theme
      @shop.transaction do
        @shop.themes.each do |current_theme|
          current_theme.role = 'unpublished'
          current_theme.save!
        end
        @installed_theme.role = 'main'
        @installed_theme.save!
        @shop.reload
      end
    end

  end
end