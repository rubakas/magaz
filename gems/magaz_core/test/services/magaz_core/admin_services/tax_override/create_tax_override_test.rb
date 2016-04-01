require 'test_helper'

class MagazCore::AdminServices::TaxOverride::CreateTaxOverrideTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, subdomain: 'example')
    @user = create(:user, shop: @shop)
    @collection = create(:collection, shop: @shop, handle: "handle1")
    @shipping_country = create(:shipping_country, shop: @shop)
    @params = { is_shipping: 'false', collection_id: @collection.id, rate: '48'}
    @params2 = { is_shipping: 'true', collection_id: @collection.id, rate: '50'}
    @blank_params = { is_shipping: false }
    @wrong_params = { is_shipping: false, collection_id: @collection.id, rate: "not_number" }
  end

  test 'create override with valid params and already existing one' do
    service = MagazCore::AdminServices::TaxOverride::CreateTaxOverride
                .call(params: @params, shipping_country_id: @shipping_country.id)
    assert service.tax_override.persisted?
    assert_equal service.tax_override.collection_id, @collection.id
    assert_equal service.tax_override.rate, 48

    service = MagazCore::AdminServices::TaxOverride::CreateTaxOverride
                .call(params: @params, shipping_country_id: @shipping_country.id)
    assert_not service.tax_override.persisted?
  end

  test 'create override with valid params2' do
    service = MagazCore::AdminServices::TaxOverride::CreateTaxOverride
                .call(params: @params2, shipping_country_id: @shipping_country.id)
    assert service.tax_override.persisted?
    assert_equal service.tax_override.collection_id, nil
    assert_equal service.tax_override.rate, 50
  end

  test 'fails to create tax_override with wrong params' do
    service = MagazCore::AdminServices::TaxOverride::CreateTaxOverride
                 .call(params: @blank_params, shipping_country_id: @shipping_country.id)
    refute service.tax_override.persisted?

    service = MagazCore::AdminServices::TaxOverride::CreateTaxOverride
                .call(params: @wrong_params, shipping_country_id: @shipping_country.id)
    refute service.tax_override.persisted?
  end
end
