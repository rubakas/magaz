require 'test_helper'
class MagazCore::AdminServices::ShippingCountry::ChangeShippingCountryTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop)
    @first_shipping_country = create(:shipping_country, shop: @shop)
    @second_shipping_country = create(:shipping_country, shop: @shop, name: "AF")
    @success_params = {tax: "69",
                       name: "AL",
                       shop_id: @shop.id,
                       id: @first_shipping_country.id}
    @blank_params = {tax: "", name: "", shop_id: @shop.id, id: @first_shipping_country.id}
  end

  test "should update shipping country with valid params" do
    assert_equal 2, MagazCore::ShippingCountry.count
    service = MagazCore::AdminServices::ShippingCountry::ChangeShippingCountry
                .run(@success_params)
    assert service.valid?
    assert_equal @success_params[:tax], MagazCore::ShippingCountry.find(service.result.id).tax
    assert_equal @success_params[:name], MagazCore::ShippingCountry.find(service.result.id).name
  end

  test "should not update shipping country with blank params" do
    assert_equal 2, MagazCore::ShippingCountry.count
    service = MagazCore::AdminServices::ShippingCountry::ChangeShippingCountry
                .run(@blank_params)
    refute service.valid?
    assert_equal 4, service.shipping_country.errors.full_messages.count
    assert_equal "Tax is not a number", service.shipping_country.errors.full_messages.first
    assert_equal "Name is not included in the list", service.shipping_country.errors.full_messages.last
  end

  test "should not update shipping country with same country title" do
    @success_params[:name] = @second_shipping_country.name
    assert_equal 2, MagazCore::ShippingCountry.count
    service = MagazCore::AdminServices::ShippingCountry::ChangeShippingCountry
                .run(@success_params)
    refute service.valid?
    assert_equal 1, service.shipping_country.errors.full_messages.count
    assert_equal "Name has already been taken", service.shipping_country.errors.full_messages.first
  end

  test "should not update shipping country with invalid tax" do
    @success_params[:tax] = "invalid tax"
    assert_equal 2, MagazCore::ShippingCountry.count
    service = MagazCore::AdminServices::ShippingCountry::ChangeShippingCountry
                .run(@success_params)
    refute service.valid?
    assert_equal 1, service.shipping_country.errors.full_messages.count
    assert_equal "Tax is not a number", service.shipping_country.errors.full_messages.first
  end
end
