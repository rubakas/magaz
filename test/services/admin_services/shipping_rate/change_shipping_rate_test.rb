require 'test_helper'
class AdminServices::ShippingRate::ChangeShippingRateTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: "New shop")
    @shipping_country = create(:shipping_country, shop: @shop)
    @shipping_rate = create(:shipping_rate, shipping_country: @shipping_country)
    @succsess_params = {
      'name'            => "Updated name",
      'price_to'        => "20.5",
      'weight_to'       => "5.5",
      'shipping_price'  => "5",
      'criteria'        => "weight",
      'price_from'      => "15.7",
      'weight_from'     => "3.1"
    }

    @blank_params = {
      'name'            =>  "",
      'price_to'        =>  "",
      'weight_to'       =>  "",
      'shipping_price'  =>  "",
      'criteria'        =>  "",
      'price_from'      =>  "",
      'weight_from'     =>  ""
    }
  end

  test "should update shipping rate with valid params" do
    assert_equal 1, ShippingRate.count
    service = AdminServices::ShippingRate::ChangeShippingRate
              .new( id:                   @shipping_rate.id,
                    shipping_country_id:  @shipping_country.id,
                    params:               @succsess_params)
              .run
    assert service.success?
    assert_equal @succsess_params['name'], ShippingRate.find(service.result.id).name
    assert_equal @succsess_params['criteria'], ShippingRate.find(service.result.id).criteria
    assert_equal @succsess_params['shipping_price'].to_f, ShippingRate.find(service.result.id).shipping_price
  end

  test "should not update shipping rate with blank params" do
    assert_equal 1, ShippingRate.count
    service = AdminServices::ShippingRate::ChangeShippingRate
              .new( id:                   @shipping_rate.id,
                    shipping_country_id:  @shipping_country.id,
                    params:               @blank_params)
              .run
    refute service.success?
    assert_equal 3, service.result.errors.full_messages.count
    assert_equal "Name can't be blank", service.result.errors.full_messages.first
    assert_equal "Criteria can't be blank", service.result.errors.full_messages.last
  end

  test "shoul update shipping rate with some blank params" do
    invalid_params = @succsess_params.merge({
      'weight_from' => "",
      'weight_to' => "",
      'price_from' => "",
      'price_to' => "" })
    assert_equal 1, ShippingRate.count
    service = AdminServices::ShippingRate::ChangeShippingRate
              .new( id:                   @shipping_rate.id,
                    shipping_country_id:  @shipping_country.id,
                    params:               invalid_params)
              .run
    assert service.success?
    assert_equal @succsess_params['name'], ShippingRate.find(service.result.id).name
    assert_nil ShippingRate.find(service.result.id).price_from
    assert_equal "weight", ShippingRate.find(service.result.id).criteria
  end

  test "should not update shipping rate with wrong criteria" do
    invalid_params = {
      'name'           => "Updated name",
      'price_to'       => "20.5",
      'weight_to'      => "",
      'shipping_price' => "5",
      'criteria'       => "weight",
      'price_from'     => "0.15",
      'weight_from'    => ""
    }

    service = AdminServices::ShippingRate::ChangeShippingRate
              .new( id:                   @shipping_rate.id,
                    shipping_country_id:  @shipping_country.id,
                    params:               invalid_params)
              .run
    refute service.success?
    assert_equal 1, service.result.errors.full_messages.count
    assert_equal "Criteria is not correct", service.result.errors.full_messages.first
  end

  test "should not update shipping rate with wrong comparison" do
    invalid_params = {
      'name'           => "Updated name",
      'price_to'       => "",
      'weight_to'      => "5.5",
      'shipping_price' => "5",
      'criteria'       => "weight",
      'price_from'     => "",
      'weight_from'    => "10.7"
    }
    service = AdminServices::ShippingRate::ChangeShippingRate
              .new( id: @shipping_rate.id,
                    shipping_country_id: @shipping_country.id,
                    params: invalid_params)
              .run
    refute service.success?
    assert_equal 1, service.result.errors.full_messages.count
    assert_equal "weight to must be greater than weight from", service.result.errors.full_messages.first
  end

  test "should not update shipping rate with wrong weight" do
    invalid_params = {
      'name'           => "Updated name",
      'price_to'       => "",
      'weight_to'      => "some",
      'shipping_price' => "5",
      'criteria'       => "weight",
      'price_from'     => "",
      'weight_from'    => "text"
    }

    service = AdminServices::ShippingRate::ChangeShippingRate
              .new( id:                   @shipping_rate.id,
                    shipping_country_id:  @shipping_country.id,
                    params:               invalid_params)
              .run

    refute service.success?
    assert_equal 2, service.result.errors.full_messages.count
    assert_equal "Weight from is not correct", service.result.errors.full_messages.first
    assert_equal "Weight to is not correct", service.result.errors.full_messages.last
  end

end
