require 'test_helper'

class Admin::ShippingRatesControllerTest < ActionController::TestCase
  setup do
    @shop = create(:shop, subdomain: 'example')
    session_for_shop @shop
    @country = create(:country, shop: @shop)
    @shipping_rate = create(:shipping_rate, country: @country)
  end

  test "should get new" do
    get :new, :country_id => @country.id
    assert_response :success
  end

  test "should create shipping_rate" do
    assert_difference('MagazCore::ShippingRate.count') do
      post :create, { :country_id => @country.id, shipping_rate: { name: 'Very Unique Name', shipping_price: '12' } }
    end
    assert_response :success
  end

  test "should show shipping_rate" do
    get :show, :country_id => @country.id, id: @shipping_rate
    assert_response :success
  end

  test "should update shipping_rate" do
    patch :update,
      { :country_id => @country.id, id: @shipping_rate.id,
        shipping_rate: { name: @shipping_rate.name } }
    assert_redirected_to admin_country_shipping_rate_path(@country, @shipping_rate)
  end

  test "should not update shipping_rate" do
    patch :update,
      { :country_id => @country.id, id: @shipping_rate.id,
        shipping_rate: { shipping_price: '', name: '' } }
    assert_template :show
    assert_response :success
  end

  test "should destroy shipping_rate" do
    assert_difference('MagazCore::ShippingRate.count', -1) do
      delete :destroy, :country_id => @country.id, id: @shipping_rate.id
    end

    assert_redirected_to admin_country_path(@country)
  end

  test "criteria validation success" do
    patch :update,
      { :country_id => @country.id, id: @shipping_rate.id,
        shipping_rate: { shipping_price: @shipping_rate.shipping_price, name: @shipping_rate.name,
                          criteria: "price", price_from: 10, price_to: 20} }
    assert_redirected_to admin_country_shipping_rate_path(@country, @shipping_rate)
  end

  test "criteria validation failure" do
    patch :update,
      { :country_id => @country.id, id: @shipping_rate.id,
        shipping_rate: { shipping_price: @shipping_rate.shipping_price, name: @shipping_rate.name,
                          criteria: "weight", price_from: 10, price_to: 20} }
    assert_template :show
    assert_response :success
  end
end
