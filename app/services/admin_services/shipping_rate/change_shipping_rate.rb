class AdminServices::ShippingRate::ChangeShippingRate

  attr_reader :success, :result
  alias_method :success?, :success

  def initialize(id:, shipping_country_id:, params:)
    shipping_country = ShippingCountry.find(shipping_country_id)
    @result = shipping_country.shipping_rates.find(id)
    @params = params
  end

  def run
    @success = @result.update_attributes(shipping_rate_params)
    self
  end

  private

  def shipping_rate_params
    @params.slice(:name, :shipping_price, :criteria, :price_from, :price_to, :weight_from, :weight_to)
  end
end
