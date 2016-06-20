require 'test_helper'

class AdminServices::TaxOverride::AddTaxOverrideTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, subdomain: 'example')
    @user = create(:user, shop: @shop)
    @collection = create(:collection, shop: @shop, handle: "handle1")
    @shipping_country = create(:shipping_country, shop: @shop)
    @success_params1 = { is_shipping: 'false',
                        collection_id: @collection.id,
                        rate: '48',
                        shipping_country_id: @shipping_country.id}
    @success_params2 = { is_shipping: 'true',
                         collection_id: nil,
                         rate: '5.4',
                         shipping_country_id: @shipping_country.id}
    @blank_params = { is_shipping: '',
                      collection_id: '',
                      rate: '',
                      shipping_country_id: @shipping_country.id }
    @wrong_params = { is_shipping: 'false',
                      collection_id: nil,
                      rate: '4',
                      shipping_country_id: @shipping_country.id }
  end

  test 'create override with valid params and already existing one' do
    service = AdminServices::TaxOverride::AddTaxOverride
                .run(@success_params1)
    assert service.valid?
    assert_equal @collection.id, service.result.collection_id
    assert_equal @shipping_country.id, service.result.shipping_country_id
    assert_equal 48.0, service.result.rate

    service = AdminServices::TaxOverride::AddTaxOverride
                .run(@success_params1)
    assert_not service.valid?
    assert_equal 1, service.errors.count
    assert_equal "Tax override already exists", service.errors.full_messages.first
  end

  test 'create override with second valid params' do
    service = AdminServices::TaxOverride::AddTaxOverride
              .run(@success_params2)
    assert service.valid?
    assert_equal nil, service.result.collection_id
    assert_equal @shipping_country.id, service.result.shipping_country_id
    assert_equal 5.4, service.result.rate
  end

  test 'fails to create tax_override with wrong params' do
    service = AdminServices::TaxOverride::AddTaxOverride
              .run(@wrong_params)
    refute service.valid?
    assert_equal 2, service.tax_override.errors.count
    assert_equal 'Wrong params for tax override',
                 service.tax_override.errors.full_messages.first
  end

  test 'fails to create tax_override with blank_params params' do
    service = AdminServices::TaxOverride::AddTaxOverride
              .run(@blank_params)
    refute service.valid?
    assert_equal 3, service.tax_override.errors.count
    assert_equal "Rate is not a valid float",
                 service.tax_override.errors.full_messages.first
    assert_equal "Collection is not a valid integer",
                 service.tax_override.errors.full_messages[1]
    assert_equal "Is shipping is not a valid boolean",
                 service.tax_override.errors.full_messages.last
  end
end
