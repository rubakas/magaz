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
              .new( shop_id: @shop.id, 
                    id: @shipping_country.id)
              .run
    assert service.success?
    refute ShippingCountry.find_by_id(@shipping_country.id)
    assert_equal 0, ShippingCountry.count
  end
end
