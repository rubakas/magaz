module MagazStoreAdmin
require 'test_helper'

class ShippingRatesControllerTest < ActionController::TestCase
  setup do
    @shop = create(:shop, subdomain: 'example')
    @user = create(:user, shop: @shop)
    session_for_user @user
    @shipping_country = create(:shipping_country, shop: @shop)
    @shipping_rate = create(:shipping_rate, shipping_country: @shipping_country)
  end

  test "should get new" do
    get :new, :shipping_country_id => @shipping_country.id
    assert_response :success
  end

  test "should create shipping_rate" do
    assert_difference('MagazCore::ShippingRate.count') do
      post :create, { :shipping_country_id => @shipping_country.id,
                       shipping_rate: { name: 'Very Unique Name', shipping_price: '12',
                                        price_to: "20.5", weight_to: "5.5",
                                        price_from: "15.7", weight_from: "3.1", } }
    end
    assert_response :success
  end

  test "should show shipping_rate" do
    get :show, :shipping_country_id => @shipping_country.id, id: @shipping_rate
    assert_response :success
  end

  test "should update shipping_rate" do
    patch :update,
      { :shipping_country_id => @shipping_country.id, id: @shipping_rate.id,
        shipping_rate: { name: @shipping_rate.name } }
    assert_redirected_to shipping_country_shipping_rate_path(@shipping_country, @shipping_rate)
  end

  test "should not update shipping_rate" do
    patch :update,
      { :shipping_country_id => @shipping_country.id, id: @shipping_rate.id,
        shipping_rate: { shipping_price: '', name: '' } }
    assert_template :show
    assert_response :success
  end

  test "should destroy shipping_rate" do
    assert_difference('MagazCore::ShippingRate.count', -1) do
      delete :destroy, :shipping_country_id => @shipping_country.id, id: @shipping_rate.id
    end

    assert_redirected_to shipping_country_path(@shipping_country)
  end

  test "criteria validation success" do
    patch :update,
      { :shipping_country_id => @shipping_country.id, id: @shipping_rate.id,
        shipping_rate: { shipping_price: @shipping_rate.shipping_price, name: @shipping_rate.name,
                          criteria: "price", price_from: 10, price_to: 20} }
    assert_redirected_to shipping_country_shipping_rate_path(@shipping_country, @shipping_rate)
  end

  test "criteria validation failure" do
    patch :update,
      { :shipping_country_id => @shipping_country.id, id: @shipping_rate.id,
        shipping_rate: { shipping_price: @shipping_rate.shipping_price, name: @shipping_rate.name,
                          criteria: "weight", price_from: 10, price_to: 20} }
    assert_template :show
    assert_response :success
  end
end
end
