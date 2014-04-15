class Services::ThemeSystem
  attr_reader :shop, :theme

  def initialize(shop_id:, theme_id:)
    @shop  = Shop.find(shop_id)
    @theme = Theme.find(theme_id)
  end

  def apply_theme
    # set default
  end

  def buy_theme
    # process payment
    # give theme access?
    # clone
  end

end