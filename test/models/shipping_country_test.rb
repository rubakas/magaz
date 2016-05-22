require 'test_helper'

class ShippingCountryTest < ActiveSupport::TestCase

  should have_many  :shipping_rates
  should belong_to  :shop
  should have_many  :tax_overrides
  
  setup do
    @shop = create(:shop)
    @shipping_country = create(:shipping_country, shop: @shop)
  end

  test "should return country info" do
    assert_equal @shipping_country.country_info['iso_2'], @shipping_country.name
  end
end
