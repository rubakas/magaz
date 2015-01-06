require 'test_helper'

class Admin::CountriesControllerTest < ActionController::TestCase
  setup do
    @shop = create(:shop, subdomain: 'example')
    session_for_shop @shop
    @country = create(:country, shop: @shop)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shipping_rate" do
    assert_difference('MagazCore::Country.count') do
      post :create, { country: { code: 'UK', tax: 10 } }
    end
    assert_redirected_to admin_country_path(assigns(:country))
  end

  test "should show country" do
    get :show, id: @country
    assert_response :success
  end

  test "should update country" do
    patch :update,
      { id: @country.id,
        country: { code: @country.code, tax: @country.tax } }
    assert_redirected_to admin_country_path(assigns(:country))
  end

  test "should not update shipping_rate" do
    patch :update,
      { id: @country.id,
        country: { code: ''} }
    assert_template :show
    assert_response :success
  end

  test "should destroy shipping_rate" do
    assert_difference('MagazCore::Country.count', -1) do
      delete :destroy, id: @country.id
    end

    assert_redirected_to admin_countries_path
  end
end
