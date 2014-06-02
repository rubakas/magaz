class MagazCore::ThemeServices::Activate
  include MagazCore::Concerns::Service
  attr_reader :shop, :installed_theme

  def call(shop_id:, installed_theme_id: nil)
    @shop          = MagazCore::Shop.find(shop_id)
    @installed_theme = MagazCore::Theme.find(installed_theme_id) unless installed_theme_id.nil?

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
