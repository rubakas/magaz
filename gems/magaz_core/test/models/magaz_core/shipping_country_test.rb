require 'test_helper'

module MagazCore
  class ShippingCountryTest < ActiveSupport::TestCase
     setup do
      @shop = create(:shop)
      @shipping_country = create(:shipping_country, shop: @shop)
    end

    test "should return country info" do
      assert_equal @shipping_country.country_info['iso_2'], @shipping_country.name
    end
  end
end