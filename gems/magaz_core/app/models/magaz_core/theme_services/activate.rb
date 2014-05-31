class MagazCore::ThemeServices::Activate
  include MagazCore::Concerns::Service
  #TODO: remove attributes not used in response
  attr_reader :shop, :source_theme, :installed_theme

  def call(shop_id:, source_theme_id: nil, installed_theme_id: nil)
    @shop          = MagazCore::Shop.find(shop_id)
    @source_theme  = MagazCore::Theme.find(source_theme_id) unless source_theme_id.nil?
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
