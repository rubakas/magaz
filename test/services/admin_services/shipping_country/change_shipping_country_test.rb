require 'test_helper'
class AdminServices::ShippingCountry::ChangeShippingCountryTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop)
    @first_shipping_country = create(:shipping_country, shop: @shop)
    @second_shipping_country = create(:shipping_country, shop: @shop, name: "AF")
    @success_params = { tax: "69", name: "AL" }
    @blank_params =   { tax: "", name: "", }
  end

  test "should update shipping country with valid params" do
    assert_equal 2, ShippingCountry.count
    service = AdminServices::ShippingCountry::ChangeShippingCountry
              .new(id: @first_shipping_country.id, shop_id: @shop.id, params: @success_params)
              .run
    assert service.success?
    assert_equal @success_params[:tax], ShippingCountry.find(service.result.id).tax
    assert_equal @success_params[:name], ShippingCountry.find(service.result.id).name
  end

  test "should not update shipping country with blank params" do
    assert_equal 2, ShippingCountry.count
    service = AdminServices::ShippingCountry::ChangeShippingCountry
                  .new(id: @first_shipping_country.id, shop_id: @shop.id, params: @blank_params)
                  .run
    refute service.success?
    assert_equal 4, service.result.errors.full_messages.count
    assert_equal "Tax is not a number", service.result.errors.full_messages.first
    assert_equal "Name is not included in the list", service.result.errors.full_messages.last
  end

  test "should not update shipping country with same country title" do
    invalid_params = @success_params.merge({ name: @second_shipping_country.name })
    assert_equal 2, ShippingCountry.count
    service = AdminServices::ShippingCountry::ChangeShippingCountry
                  .new(id: @first_shipping_country.id, shop_id: @shop.id, params: invalid_params)
                  .run
    refute service.success?
    assert_equal 1, service.result.errors.full_messages.count
    assert_equal "Name has already been taken", service.result.errors.full_messages.first
  end

  test "should not update shipping country with invalid tax" do
    invalid_params = @success_params.merge({ tax: "invalid tax" })
    assert_equal 2, ShippingCountry.count
    service = AdminServices::ShippingCountry::ChangeShippingCountry
                  .new(id: @first_shipping_country.id, shop_id: @shop.id, params: invalid_params)
                  .run
    refute service.success?
    assert_equal 1, service.result.errors.full_messages.count
    assert_equal "Tax is not a number", service.result.errors.full_messages.first
  end
end
