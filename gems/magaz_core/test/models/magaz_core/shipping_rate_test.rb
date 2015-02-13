require 'test_helper'

module MagazCore
  class ShippingRateTest < ActiveSupport::TestCase
    setup do
      @shop = create(:shop)
      @shipping_country = create(:shipping_country, shop: @shop)
      @shipping_rate = create(:shipping_rate, shipping_country: @shipping_country)
    end

    test 'should have the necessary required validators' do
      shipping_rate = MagazCore::ShippingRate.new(shipping_country: @shipping_country)
      assert_not shipping_rate.valid?
      assert_equal [:name, :shipping_price], shipping_rate.errors.keys
    end

    test "should have numeric shipping_price" do
      shipping_rate = MagazCore::ShippingRate.new(name: @shipping_rate.name, shipping_country: @shipping_country,
                                                  shipping_price: "number")
      assert_not shipping_rate.valid?
      assert_equal ["is not a number"], shipping_rate.errors.messages[:shipping_price]
    end

    test "should have numeric weight range" do
      shipping_rate = MagazCore::ShippingRate.new(name: @shipping_rate.name, shipping_country: @shipping_country,
                                                  criteria: "weight", weight_from: "from", weight_to: "to",
                                                  shipping_price: @shipping_rate.shipping_price)
      assert_not shipping_rate.valid?
      assert_equal ["is not a number"], shipping_rate.errors.messages[:weight_from]
      assert_equal ["is not a number"], shipping_rate.errors.messages[:weight_to]
    end

    test "should have numeric price range" do
      shipping_rate = MagazCore::ShippingRate.new(name: @shipping_rate.name, shipping_country: @shipping_country,
                                                  criteria: "price", price_from: "from", price_to: "to",
                                                  shipping_price: @shipping_rate.shipping_price)
      assert_not shipping_rate.valid?
      assert_equal ["is not a number"], shipping_rate.errors.messages[:price_from]
      assert_equal ["is not a number"], shipping_rate.errors.messages[:price_to]
    end

    test "should have price criteria" do
      shipping_rate = MagazCore::ShippingRate.new(name: @shipping_rate.name, shipping_country: @shipping_country,
                                                  criteria: "weight", price_from: "2", price_to: "3",
                                                  shipping_price: @shipping_rate.shipping_price)
      assert_not shipping_rate.valid?
      assert_equal ["Criteria is not correct"], shipping_rate.errors.messages[:criteria]
    end

    test "should have weight criteria" do
      shipping_rate = MagazCore::ShippingRate.new(name: @shipping_rate.name, shipping_country: @shipping_country,
                                                  criteria: "price", weight_from: "2", weight_to: "3",
                                                  shipping_price: @shipping_rate.shipping_price)
      assert_not shipping_rate.valid?
      assert_equal ["Criteria is not correct"], shipping_rate.errors.messages[:criteria]
    end

    test "shoud have right price comparison" do
      shipping_rate = MagazCore::ShippingRate.new(name: @shipping_rate.name, shipping_country: @shipping_country,
                                                  criteria: "price", price_from: "5", price_to: "3",
                                                  shipping_price: @shipping_rate.shipping_price)
      assert_not shipping_rate.valid?
      assert_equal ["price_to must be greater than price_from"], shipping_rate.errors.messages[:price_to]
    end

    test "shoud have right weight comparison" do
      shipping_rate = MagazCore::ShippingRate.new(name: @shipping_rate.name, shipping_country: @shipping_country,
                                                  criteria: "weight", weight_from: "5", weight_to: "3",
                                                  shipping_price: @shipping_rate.shipping_price)
      assert_not shipping_rate.valid?
      assert_equal ["weight_to must be greater than weight_from"], shipping_rate.errors.messages[:weight_to]
    end
  end
end