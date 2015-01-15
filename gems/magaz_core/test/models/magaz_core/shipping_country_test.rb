require 'test_helper'

module MagazCore
  class ShippingCountryTest < ActiveSupport::TestCase
     setup do
      @shop = create(:shop)
      @shipping_country = create(:shipping_country, shop: @shop)
    end

    test 'should have the necessary required validators' do
      shipping_country = MagazCore::ShippingCountry.new(shop: @shop)
      assert_not shipping_country.valid?
      assert_equal [:tax, :name], shipping_country.errors.keys
    end

    test "should have numeric tax" do
      shipping_country = MagazCore::ShippingCountry.new(shop: @shop, name: @shipping_country.name, tax: "number")
      assert_not shipping_country.valid?
      assert_equal ["is not a number"], shipping_country.errors.messages[:tax]
    end
  end
end