class ThemeServices::Activate< ActiveInteraction::Base

  integer :shop_id
  integer :installed_theme_id, default: nil

  validates :shop_id, :installed_theme_id, presence: true

  def execute
    @shop           = Shop.find(shop_id)
    @installed_theme = Theme.find(installed_theme_id)

    @shop.transaction do
      @shop.themes.each do |current_theme|
        current_theme.deactivate!
      end
      @installed_theme.activate!
      @shop.reload
    end
    @installed_theme
  end

end
