require 'test_helper'

class ShippingCountryTest < ActiveSupport::TestCase

  should have_many  :shipping_rates
  should belong_to  :shop
  should have_many  :tax_overrides
  should validate_presence_of(:tax)
  should validate_presence_of(:tax)
  should validate_presence_of(:name)
  should validate_presence_of(:shop_id)
  should validate_uniqueness_of(:name).scoped_to(:shop_id)
  setup do
    @shop = create(:shop)
    @shipping_country = create(:shipping_country, shop: @shop)
  end

  test "should return country info" do
    assert_equal @shipping_country.country_info['iso_2'], @shipping_country.name
  end
end
