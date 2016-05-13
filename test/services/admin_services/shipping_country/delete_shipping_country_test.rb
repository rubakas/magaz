require 'test_helper'

class AdminServices::ShippingCountry::DeleteShippingCountryTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop)
    @another_shop = create(:shop)
    @shipping_country = create(:shipping_country, shop: @shop)
  end

  test "should delete shipping country with valid ids" do
    assert_equal 1, ShippingCountry.count
    service = AdminServices::ShippingCountry::DeleteShippingCountry
                .run(shop_id: @shop.id,
                     id: @shipping_country.id)
    assert service.valid?
    refute ShippingCountry.find_by_id(@shipping_country.id)
    assert_equal 0, ShippingCountry.count
  end

  test "should not delete shipping country with blank ids" do
    assert_equal 1, ShippingCountry.count
    service = AdminServices::ShippingCountry::DeleteShippingCountry
                .run(shop_id: "", id: "")
    refute service.valid?
    assert_equal 2, service.errors.count
    assert_equal "Shop is not a valid integer", service.errors.full_messages.last
    assert ShippingCountry.find_by_id(@shipping_country.id)
    assert_equal 1, ShippingCountry.count
  end

  test "should not delete shipping country with invalid ids" do
    assert_equal 1, ShippingCountry.count
    service = AdminServices::ShippingCountry::DeleteShippingCountry
                .run(shop_id: @another_shop.id, id: @shipping_country)
    refute service.valid?
    assert ShippingCountry.find_by_id(@shipping_country.id)
    assert_equal 1, ShippingCountry.count
  end
end
