class MagazCore::AdminServices::TaxOverride::CreateTaxOverride
  include MagazCore::Concerns::Service
  attr_accessor :tax_override

  def call(params: {}, shipping_country_id:)
    @tax_override = MagazCore::TaxOverride.new

    MagazCore::TaxOverride.connection.transaction do
      begin
        _check_for_uniqueness(params: params, shipping_country_id: shipping_country_id)
        _check_method(params: params)
        _create_tax_override_with_valid_params!(params: params, shipping_country_id: shipping_country_id, override: @tax_override)
      rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid, ArgumentError
        raise ActiveRecord::Rollback
      end
    end
  end

  private

  def _check_for_uniqueness(params: {}, shipping_country_id:)
    shipping_country = MagazCore::ShippingCountry.find_by_id(shipping_country_id)
    if params[:is_shipping] == 'false'
      override = shipping_country.tax_overrides.find_by(collection_id: params[:collection_id])
    else
      override = shipping_country.tax_overrides.find_by(is_shipping: true)
    end
    unless override == nil
      fail(ArgumentError)
    end
  end

  def _check_method(params: {})
    if params[:is_shipping] == 'false' && params[:collection_id] == ""
      fail(ArgumentError)
    end
  end

  def _create_tax_override_with_valid_params!(params: {}, shipping_country_id:, override:)
    override_params = params.merge(shipping_country_id: shipping_country_id)
    tax_override.attributes = override_params
    tax_override.save! || fail(ArgumentError)
  end
end
