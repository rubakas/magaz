class AdminServices::TaxOverride::ChangeTaxOverride

  attr_reader :success, :result
  alias_method :success?, :success

  def initialize  id:,
                  shipping_country_id:,
                  params:
    shipping_country = ::ShippingCountry.find_by_id(shipping_country_id)
    @result = shipping_country.tax_overrides.find_by_id(id)
    @params = params
  end

  def run
    @result.attributes = shipping_country_params
    check_collection_id!
    if_shipping!
    @success = @result.save
    self
  end

  private
  def shipping_country_params
    @params.slice 'rate', 'collection_id', 'is_shipping'
  end

  def check_collection_id!
    @result.collection_id = nil if @result.collection_id == 0
  end

  def if_shipping!
    @result.collection_id = nil if @result.is_shipping
  end
end
