class AdminServices::ShippingCountry::DeleteShippingCountry

  attr_reader :success
  attr_reader :result
  alias_method :success?, :success

  def initialize id:, shop_id:
    @result = Shop.find(shop_id)
              .shipping_countries
              .find(id)
  end

  def run
    @success = @result.destroy
    self
  end
end
