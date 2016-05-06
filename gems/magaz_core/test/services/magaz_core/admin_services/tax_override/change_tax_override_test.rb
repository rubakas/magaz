require 'test_helper'

class MagazCore::AdminServices::TaxOverride::ChangeTaxOverrideTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, subdomain: 'example')
    @user = create(:user, shop: @shop)
    @collection = create(:collection, shop: @shop, handle: "handle1")
    @shipping_country = create(:shipping_country, shop: @shop)
    @tax_override = create(:tax_override, shipping_country: @shipping_country)
    @success_params = { id: @tax_override.id,
                        is_shipping: 'false',
                        collection_id: @collection.id,
                        shipping_country_id: @shipping_country.id,
                        rate: '48'}
    @blank_params = { id: @tax_override.id,
                      is_shipping: '',
                      collection_id: '',
                      shipping_country_id: @shipping_country.id,
                      rate: '' }
  end

  test 'should change override with valid params' do
    service = MagazCore::AdminServices::TaxOverride::ChangeTaxOverride
                .run(@success_params)
    assert service.valid?
    assert_equal false, service.result.is_shipping
    assert_equal 48.0, service.result.rate
    assert_equal @collection.id, service.result.collection_id
    assert_equal @shipping_country.id, service.result.shipping_country_id
  end

  test 'should not change override with blank params' do
    service = MagazCore::AdminServices::TaxOverride::ChangeTaxOverride
                .run(@blank_params)
    refute service.valid?
    assert_equal 3, service.tax_override.errors.count
    assert_equal "Collection is not a valid integer",
                 service.tax_override.errors.full_messages.first
    assert_equal "Rate is not a valid float",
                 service.tax_override.errors.full_messages[1]
    assert_equal "Is shipping is not a valid boolean",
                 service.tax_override.errors.full_messages.last
  end
end
