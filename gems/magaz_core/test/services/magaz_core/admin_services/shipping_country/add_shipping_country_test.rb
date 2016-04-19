require 'test_helper'
class MagazCore::AdminServices::ShippingCountry::AddShippingCountryTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop)
    @shipping_country = create(:shipping_country, shop: @shop)
    @success_params = {shop_id: @shop.id, tax: "1488", name: "AF"}
    @blank_params = {shop_id: "", tax: "", name: ""}
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

end