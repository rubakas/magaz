class AdminServices::TaxOverride::AddTaxOverride

  attr_reader :success, :result
  alias_method :success?, :success

  def initialize(shipping_country_id:, params:)
    @result = ::ShippingCountry
              .find_by_id(shipping_country_id)
              .tax_overrides.new(default_params)
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
    @params.slice 'rate',
                  'collection_id',
                  'is_shipping'
  end

  def default_params
    { 'collection_id' => nil, 'is_shipping' => false }
  end

  def check_collection_id!
    @result.collection_id = nil if @result.collection_id == 0
  end

  def if_shipping!
    @result.collection_id = nil if @result.is_shipping
  end
end
