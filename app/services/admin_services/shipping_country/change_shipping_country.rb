class AdminServices::ShippingCountry::ChangeShippingCountry

  attr_reader :success
  attr_reader :result
  alias_method :success?, :success

  def initialize(id:, shop_id:, params:)
    @result = ::Shop.find(shop_id).shipping_countries.find(id)
    @params = params
  end

  def run
    @success = @result.update_attributes(shipping_country_params)
    self
  end

  private

  def shipping_country_params
    @params.slice('tax', 'name')
  end
end
