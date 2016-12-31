class AdminServices::ShippingRate::DeleteShippingRate

  attr_reader :success, :result
  alias_method :success?, :success

  def initialize id:, shipping_country_id:
    @result = ::ShippingCountry.find(shipping_country_id)
              .shipping_rates.find(id)
  end

  def run
    @success = @result.destroy
    self
  end
end
