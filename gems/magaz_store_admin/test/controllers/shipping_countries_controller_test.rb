module MagazStoreAdmin
require 'test_helper'

class ShippingCountriesControllerTest < ActionController::TestCase
  setup do
    @shop = create(:shop, subdomain: 'example')
    @user = create(:user, shop: @shop)
    session_for_user @user
    @shipping_country = create(:shipping_country, shop: @shop)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shipping country" do
    assert_difference('MagazCore::ShippingCountry.count') do
      post :create, { shipping_country: { name: 'FI', tax: 10 } }
    end
    assert_redirected_to shipping_country_path(assigns(:shipping_country))
  end

  test "should show country" do
    get :show, id: @shipping_country
    assert_response :success
  end

  test "should update shipping country" do
    patch :update,
      { id: @shipping_country.id,
        shipping_country: { name: "UA", tax: @shipping_country.tax, shop_id: @shop.id } }
    assert_redirected_to shipping_country_path(assigns(:shipping_country))
  end

  test "should not update shipping country" do
    patch :update,
      { id: @shipping_country.id,
        shipping_country: { name: ''} }
    assert_template :show
    assert_response :success
  end

  test "should destroy shipping country" do
    assert_difference('MagazCore::ShippingCountry.count', -1) do
      delete :destroy, id: @shipping_country.id
    end

    assert_redirected_to shipping_countries_path
  end
end
end
