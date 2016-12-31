require 'test_helper'

class AdminServices::TaxOverride::ChangeTaxOverrideTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, subdomain: 'example')
    @user = create(:user, shop: @shop)
    @collection = create(:collection, shop: @shop, handle: "handle1")
    @shipping_country = create(:shipping_country, shop: @shop)
    @tax_override = create(:tax_override, shipping_country: @shipping_country, collection: @collection)
    @success_params = {
      'is_shipping'   => 'false',
      'collection_id' => @collection.id,
      'rate'          => '48'
    }
    @blank_params = {
      'is_shipping'   => '',
      'collection_id' => '',
      'rate'          => ''
    }
  end

  test 'should change override with valid params' do
    service = AdminServices::TaxOverride::ChangeTaxOverride
              .new( id: @tax_override.id,
                    shipping_country_id: @shipping_country.id,
                    params: @success_params)
              .run
    assert service.success?
    assert_equal false, service.result.is_shipping
    assert_equal 48.0, service.result.rate
    assert_equal @collection.id, service.result.collection_id
    assert_equal @shipping_country.id, service.result.shipping_country_id
  end

  test 'should not change override with blank params' do
    service = AdminServices::TaxOverride::ChangeTaxOverride
              .new( id: @tax_override.id,
                    shipping_country_id: @shipping_country.id,
                    params: @blank_params)
              .run
    refute service.success?
    assert_equal 2, service.result.errors.count
    assert_equal "Rate can't be blank",
                 service.result.errors.full_messages.first
    assert_equal "Wrong params for tax override",
                 service.result.errors.full_messages.last
  end
end
