class AdminServices::Shop::ChangeTaxesSettings

  attr_reader :success, :shop, :errors
  alias_method :success?, :success

  def initialize(shop_id: nil, params: { all_taxes_are_included: nil,
                                         charge_taxes_on_shipping_rates: nil,
                                         charge_vat_taxes: nil })
    @shop = Shop.find(shop_id)
    @params = params
  end

  def run
    @shop.assign_attributes(taxes_settings_params)
    if @shop.valid?
      @success = true
      @shop.save
    else
      @success = false
      @errors = @shop.errors
    end
    self
  end

  private

  def taxes_settings_params
    @params[:eu_digital_goods_collection_id] = nil unless @params[:charge_vat_taxes] == 'charge_vat_taxes'
    @params = @params.except(:charge_vat_taxes)

    @params
  end
end
