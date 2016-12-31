class AdminServices::ShippingCountry::AddShippingCountry

  attr_reader :success
  attr_reader :result
  alias_method :success?, :success

  def initialize(shop_id:, params:)
    @result = ::Shop.find(shop_id).shipping_countries.new
    @params = params
  end

  def run
    @result.attributes = shipping_country_params
    @success = @result.save
    self
  end

  private

  def shipping_country_params
    @params.slice('tax', 'name')
  end
end
