require 'test_helper'
class AdminServices::ShippingCountry::AddShippingCountryTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop)
    @shipping_country = create(:shipping_country, shop: @shop)
    @success_params = { 'tax' => "1488", 'name' => "AF" }
    @blank_params = { 'tax' => "", 'name' => "" }
  end

  test "should create shipping country with valid params" do
    assert_equal 1, ShippingCountry.count
    service = AdminServices::ShippingCountry::AddShippingCountry
              .new( shop_id:  @shop.id,
                    params:   @success_params)
              .run
    assert service.success?
    assert ShippingCountry.find_by_id(service.result.id)
    assert_equal @success_params['tax'], service.result.tax
    assert_equal 2, ShippingCountry.count
  end

  test "should not create shipping country with blank params" do
    assert_equal 1, ShippingCountry.count
    service = AdminServices::ShippingCountry::AddShippingCountry
              .new( shop_id:  @shop.id,
                    params:   @blank_params)
              .run
    refute service.success?
    assert_equal 4, service.result.errors.full_messages.count
    assert_includes service.result.errors.full_messages, "Tax is not a number"
    assert_includes service.result.errors.full_messages, "Name is not included in the list"
    assert_equal 1, ShippingCountry.count
  end

  test "should not create existing shipping country" do
    invalid_params = @success_params.merge({ 'name' => @shipping_country.name })
    assert_equal 1, ShippingCountry.count
    service = AdminServices::ShippingCountry::AddShippingCountry
              .new( shop_id: @shop.id,
                    params: invalid_params)
              .run
    refute service.success?
    assert_equal 1, service.result.errors.full_messages.count
    assert_includes service.result.errors.full_messages, "Name has already been taken"
    assert_equal 1, ShippingCountry.count
  end

  test "should not create shipping country with invalid tax" do
    invalid_params = @success_params.merge({ 'tax' => "VERY BIG TAX" })
    assert_equal 1, ShippingCountry.count
    service = AdminServices::ShippingCountry::AddShippingCountry
              .new(shop_id: @shop.id, params: invalid_params)
              .run
    refute service.success?
    assert_equal 1, service.result.errors.full_messages.count
    assert_includes service.result.errors.full_messages, "Tax is not a number"
    assert_equal 1, ShippingCountry.count
  end

  test "should not create shipping country with invalid name" do
    invalid_params = @success_params.merge({ 'name' => "AX" })
    assert_equal 1, ShippingCountry.count
    service = AdminServices::ShippingCountry::AddShippingCountry
              .new(shop_id: @shop.id, params: invalid_params)
              .run
    refute service.success?
    assert_equal 1, service.result.errors.full_messages.count
    assert_includes service.result.errors.full_messages, "Name is not included in the list"
    assert_equal 1, ShippingCountry.count
  end
end
