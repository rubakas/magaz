class MagazCore::ThemeServices::Install
  include MagazCore::Concerns::Service
  attr_reader :shop, :source_theme, :installed_theme

  def call(shop_id:, source_theme_id: nil)
    @shop          = MagazCore::Shop.find(shop_id)
    @source_theme  = MagazCore::Theme.find(source_theme_id)

    #TODO: process payment
    # copy theme data and associate with shop

    @installed_theme =
      @shop.themes.build(name: @source_theme.name, source_theme: @source_theme)

    @source_theme.assets.each do |source_asset|
      @installed_theme
        .assets
        .build(source_asset.attributes.reject { |k| 'id' == k.to_s })
    end
    @installed_theme.save!
  end

end
