require 'test_helper'

class AdminServices::TaxOverride::AddTaxOverrideTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, subdomain: 'example')
    @user = create(:user, shop: @shop)
    @collection = create(:collection, shop: @shop, handle: "handle1")
    @shipping_country = create(:shipping_country, shop: @shop)
    @success_params1 = {
                         'is_shipping' => false,
                         'collection_id' => @collection.id,
                         'rate' => '48',
                       }
    @success_params2 = {
                         'is_shipping' => true,
                         'collection_id' => nil,
                         'rate' => '5.4',
                       }
    @blank_params = {
                      'is_shipping' => '',
                      'collection_id' => '',
                      'rate' => '',
                    }
    @wrong_params = {
                      'is_shipping' => 'false',
                      'collection_id' => nil,
                      'rate' => '4',
                    }
  end

  test 'create override with valid params and already existing one' do
    service = AdminServices::TaxOverride::AddTaxOverride
              .new( shipping_country_id: @shipping_country.id,
                    params: @success_params1)
              .run
    assert service.success?
    assert_equal @collection.id, service.result.collection_id
    assert_equal @shipping_country.id, service.result.shipping_country_id
    assert_equal 48.0, service.result.rate

    service = AdminServices::TaxOverride::AddTaxOverride
              .new( shipping_country_id: @shipping_country.id,
                    params: @success_params1)
              .run
    refute service.success?
    assert_equal 1, service.result.errors.count
    assert_equal "Collection has already been taken", service.result.errors.full_messages.first
  end

  test 'create override with second valid params' do
    service = AdminServices::TaxOverride::AddTaxOverride
              .new( shipping_country_id: @shipping_country.id,
                    params: @success_params2)
              .run
    assert service.success?
    assert_nil service.result.collection_id
    assert_equal @shipping_country.id, service.result.shipping_country_id
    assert_equal 5.4, service.result.rate
  end

  test 'fails to create tax_override with wrong params' do
    service = AdminServices::TaxOverride::AddTaxOverride
              .new( shipping_country_id: @shipping_country.id,
                    params: @wrong_params)
              .run
    refute service.success?
    assert_equal 1, service.result.errors.count
    assert_equal 'Wrong params for tax override',
                 service.result.errors.full_messages.first
  end

  test 'fails to create tax_override with blank_params params' do
    service = AdminServices::TaxOverride::AddTaxOverride
              .new( shipping_country_id: @shipping_country.id,
                    params:               @blank_params)
              .run
    refute service.success?
    assert_equal 2, service.result.errors.count
    assert_equal "Rate can't be blank",
                 service.result.errors.full_messages.first
    assert_equal "Wrong params for tax override",
                 service.result.errors.full_messages.last
  end
end
