class ThemeServices::Activate
  include Concerns::Service
  attr_reader :shop, :installed_theme

  def call(shop_id:, installed_theme_id: nil)
    @shop          = Shop.find(shop_id)
    @installed_theme = Theme.find(installed_theme_id)

    @shop.transaction do
      @shop.themes.each do |current_theme|
        current_theme.deactivate!
      end
      @installed_theme.activate!
      @shop.reload
    end
  end

end
