require 'test_helper'
class AdminServices::ShippingRate::AddShippingRateTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: "New shop")
    @shipping_country = create(:shipping_country, shop: @shop)
    @succsess_params = {name: "Test name",
                        price_to: "20.5",
                        weight_to: "5.5",
                        shipping_price: "5",
                        criteria: "weight",
                        price_from: "15.7",
                        weight_from: "3.1",
                        }
    @blank_params = {name: "",
                     price_to: "",
                     weight_to: "",
                     shipping_price: "",
                     criteria: "",
                     price_from: "",
                     weight_from: "",
                     }
  end

  test "should add shipping rate with valid params" do
    assert_equal 0, ShippingRate.count
    service = AdminServices::ShippingRate::AddShippingRate
              .new(shipping_country_id: @shipping_country.id, params: @succsess_params)
              .run
    assert service.success?
    assert ShippingRate.find(service.result.id)
    assert_equal 1, ShippingRate.count
    assert_equal @succsess_params[:name], ShippingRate.find(service.result.id).name
  end

  test "should not add shipping rate with blank params" do
    assert_equal 0, ShippingRate.count
    service = AdminServices::ShippingRate::AddShippingRate
              .new(shipping_country_id: @shipping_country.id, params: @blank_params)
              .run
    refute service.success?
    assert_equal 3, service.result.errors.full_messages.count
    assert_equal "Name can't be blank", service.result.errors.full_messages.first
    assert_equal "Criteria can't be blank", service.result.errors.full_messages.last
    assert_equal 0, ShippingRate.count
  end

  test "shoul add shipping rate with some blank params" do
    invalid_params = @succsess_params.merge({ weight_from: "", weight_to: "", price_from: "", price_to: "" })
    assert_equal 0, ShippingRate.count
    service = AdminServices::ShippingRate::AddShippingRate
              .new(shipping_country_id: @shipping_country.id, params: invalid_params)
              .run
    assert service.success?
    assert ShippingRate.find(service.result.id)
    assert_equal 1, ShippingRate.count
    assert_equal @succsess_params[:name], ShippingRate.find(service.result.id).name
    assert_nil ShippingRate.find(service.result.id).price_from
  end

  test "should not add shipping rate with wrong criteria" do
    invalid_params = {
                        name: "Test name",
                        price_to: "20.5",
                        weight_to: "",
                        shipping_price: "5",
                        criteria: "weight",
                        price_from: "0.15",
                        weight_from: ""
                     }
    assert_equal 0, ShippingRate.count
    service = AdminServices::ShippingRate::AddShippingRate
              .new(shipping_country_id: @shipping_country.id, params: invalid_params)
              .run
    refute service.success?
    assert_equal 1, service.result.errors.full_messages.count
    assert_equal "Criteria is not correct", service.result.errors.full_messages.first
    assert_equal 0, ShippingRate.count
  end

  test "should not add shipping rate with wrong comparison" do
    invalid_params = {
                        name: "Test name",
                        price_to: "",
                        weight_to: "5.5",
                        shipping_price: "5",
                        criteria: "weight",
                        price_from: "",
                        weight_from: "10.7"
                    }
    assert_equal 0, ShippingRate.count
    service = AdminServices::ShippingRate::AddShippingRate
              .new(shipping_country_id: @shipping_country.id, params: invalid_params)
              .run
    refute service.success?
    assert_equal 1, service.result.errors.full_messages.count
    assert_equal "weight to must be greater than weight from", service.result.errors.full_messages.first
    assert_equal 0, ShippingRate.count
  end

  test "should not add shipping rate with wrong weight" do
    invalid_params = {
                        name: "Test name",
                        price_to: "",
                        weight_to: "some",
                        shipping_price: "5",
                        criteria: "weight",
                        price_from: "",
                        weight_from: "text",
                    }
    assert_equal 0, ShippingRate.count
    service = AdminServices::ShippingRate::AddShippingRate
                .new(shipping_country_id: @shipping_country.id, params: invalid_params)
                .run
    refute service.success?
    assert_equal 2, service.result.errors.full_messages.count
    assert_equal "Weight from is not correct", service.result.errors.full_messages.first
    assert_equal "Weight to is not correct", service.result.errors.full_messages.last
    assert_equal 0, ShippingRate.count
  end

end
