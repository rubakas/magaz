require 'test_helper'
class MagazCore::AdminServices::ShippingCountry::AddShippingCountryTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop)
    @shipping_country = create(:shipping_country, shop: @shop)
    @success_params = {shop_id: @shop.id, tax: "1488", name: "AF"}
    @blank_params = {shop_id: @shop.id, tax: "", name: ""}
  end

  test "should create shipping country with valid params" do
    assert_equal 1, MagazCore::ShippingCountry.count
    service = MagazCore::AdminServices::ShippingCountry::AddShippingCountry
                .run(@success_params)
    assert service.valid?
    assert MagazCore::ShippingCountry.find_by_id(service.result.id)
    assert_equal @success_params[:tax], service.result.tax
    assert_equal 2, MagazCore::ShippingCountry.count
  end

  test "should not create shipping country with blank params" do
    assert_equal 1, MagazCore::ShippingCountry.count
    service = MagazCore::AdminServices::ShippingCountry::AddShippingCountry
                .run(@blank_params)
    refute service.valid?
    assert_equal 4, service.shipping_country.errors.full_messages.count
    assert_equal "Tax is not a number", service.shipping_country.errors.full_messages.first
    assert_equal "Name is not included in the list", service.shipping_country.errors.full_messages.last
    assert_equal 1, MagazCore::ShippingCountry.count
  end

  test "should not create existing shipping country" do
    @success_params[:name] = @shipping_country.name
    assert_equal 1, MagazCore::ShippingCountry.count
    service = MagazCore::AdminServices::ShippingCountry::AddShippingCountry
                .run(@success_params)
    refute service.valid?
    assert_equal 1, service.shipping_country.errors.full_messages.count
    assert_equal "This shipping country has already been added", service.shipping_country.errors.full_messages.first
    assert_equal 1, MagazCore::ShippingCountry.count
  end

  test "should not create shipping country with invalid tax" do
    @success_params[:tax] = "VERY BIG TAX" 
    assert_equal 1, MagazCore::ShippingCountry.count
    service = MagazCore::AdminServices::ShippingCountry::AddShippingCountry
                .run(@success_params)
    refute service.valid?
    assert_equal 1, service.shipping_country.errors.full_messages.count
    assert_equal "Tax is not a number", service.shipping_country.errors.full_messages.first
    assert_equal 1, MagazCore::ShippingCountry.count
  end

  test "should not create shipping country with invalid name" do
    @success_params[:name] = "AX" 
    assert_equal 1, MagazCore::ShippingCountry.count
    service = MagazCore::AdminServices::ShippingCountry::AddShippingCountry
                .run(@success_params)
    refute service.valid?
    assert_equal 1, service.shipping_country.errors.full_messages.count
    assert_equal "Name is not included in the list", service.shipping_country.errors.full_messages.first
    assert_equal 1, MagazCore::ShippingCountry.count
  end

end