require 'test_helper'
class MagazCore::AdminServices::ShippingRate::ChangeShippingRateTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: "New shop")
    @shipping_country = create(:shipping_country, shop: @shop)
    @shipping_rate = create(:shipping_rate, shipping_country: @shipping_country)
    @succsess_params = {name: "Updated name",
                        price_to: "20.5",
                        weight_to: "5.5",
                        shipping_price: "5",
                        criteria: "weight",
                        price_from: "15.7",
                        weight_from: "3.1",
                        id: @shipping_rate.id,
                        shipping_country_id: @shipping_country.id}
    @blank_params = {name: "",
                     price_to: "",
                     weight_to: "",
                     shipping_price: "",
                     criteria: "",
                     price_from: "",
                     weight_from: "",
                     id: @shipping_rate.id,
                     shipping_country_id: @shipping_country.id}
  end

  test "should update shipping rate with valid params" do
    assert_equal 1, MagazCore::ShippingRate.count
    service = MagazCore::AdminServices::ShippingRate::ChangeShippingRate.run(@succsess_params)
    assert service.valid?
    assert_equal @succsess_params[:name], MagazCore::ShippingRate.find(service.result.id).name
    assert_equal @succsess_params[:criteria], MagazCore::ShippingRate.find(service.result.id).criteria
    assert_equal @succsess_params[:shipping_price].to_f, MagazCore::ShippingRate.find(service.result.id).shipping_price
  end

  test "should not update shipping rate with blank params" do
    assert_equal 1, MagazCore::ShippingRate.count
    service = MagazCore::AdminServices::ShippingRate::ChangeShippingRate.run(@blank_params)
    refute service.valid?
    assert_equal 3, service.errors.full_messages.count
    assert_equal "Name can't be blank", service.errors.full_messages.first
    assert_equal "Criteria can't be blank", service.errors.full_messages.last
  end

  test "shoul update shipping rate with some blank params" do
    @succsess_params[:weight_from] = ""
    @succsess_params[:weight_to] = ""
    @succsess_params[:price_from] = ""
    @succsess_params[:price_to] = ""
    assert_equal 1, MagazCore::ShippingRate.count
    service = MagazCore::AdminServices::ShippingRate::ChangeShippingRate.run(@succsess_params)
    assert service.valid?
    assert_equal @succsess_params[:name], MagazCore::ShippingRate.find(service.result.id).name
    assert_equal nil, MagazCore::ShippingRate.find(service.result.id).price_from
    assert_equal "weight", MagazCore::ShippingRate.find(service.result.id).criteria
  end

  test "should not update shipping rate with wrong criteria" do
    service = MagazCore::AdminServices::ShippingRate::ChangeShippingRate
                .run(name: "Updated name",
                     price_to: "20.5",
                     weight_to: "",
                     shipping_price: "5",
                     criteria: "weight",
                     price_from: "0.15",
                     weight_from: "",
                     id: @shipping_rate.id,
                     shipping_country_id: @shipping_country.id)
    refute service.valid?
    assert_equal 1, service.errors.full_messages.count
    assert_equal "Criteria is not correct", service.errors.full_messages.first
  end

  test "should not update shipping rate with wrong comparison" do
    service = MagazCore::AdminServices::ShippingRate::ChangeShippingRate
                .run(name: "Updated name",
                     price_to: "",
                     weight_to: "5.5",
                     shipping_price: "5",
                     criteria: "weight",
                     price_from: "",
                     weight_from: "10.7",
                     id: @shipping_rate.id,
                     shipping_country_id: @shipping_country.id)
    refute service.valid?
    assert_equal 1, service.errors.full_messages.count
    assert_equal "weight to must be greater than weight from", service.errors.full_messages.first
  end

  test "should not update shipping rate with wrong weight" do
    service = MagazCore::AdminServices::ShippingRate::ChangeShippingRate
                .run(name: "Updated name",
                     price_to: "",
                     weight_to: "some",
                     shipping_price: "5",
                     criteria: "weight",
                     price_from: "",
                     weight_from: "text",
                     id: @shipping_rate.id,
                     shipping_country_id: @shipping_country.id)
    refute service.valid?
    assert_equal 2, service.errors.full_messages.count
    assert_equal "Weight from is not correct", service.errors.full_messages.first
    assert_equal "Weight to is not correct", service.errors.full_messages.last
  end
  
end