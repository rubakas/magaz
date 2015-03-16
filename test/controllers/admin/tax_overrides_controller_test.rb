require 'test_helper'

class Admin::TaxOverridesControllerTest < ActionController::TestCase
  setup do
    @shop = create(:shop, subdomain: 'example')
    @user = create(:user, shop: @shop)
    session_for_user @user
    @country = create(:country)
    @collection = create(:collection, shop: @shop, handle: "handle1")
    @shop.update_attributes(eu_digital_goods_collection_id: @collection.id)
    @shipping_country = create(:another_shipping_country, shop: @shop, country_id: @country.id)
    @tax_override = create(:tax_override, shipping_country: @shipping_country, collection_id: @collection.id)
  end

  test "should get new" do
    get :new, {shipping_country_id: @shipping_country.id}
    assert_response :success
  end

  test "should show user" do
    get :show,
      id: @shipping_country
    assert_response :success
  end

  test "should destroy tax override" do
    assert_difference('MagazCore::TaxOverride.count', -1) do
      delete :destroy, id: @tax_override.id
    end

    assert_redirected_to admin_tax_override_path(assigns(:shipping_country))
  end

  test "should create tax override" do
    assert_difference('MagazCore::TaxOverride.count') do
      post :create, { shipping_country_id: @shipping_country.id,
                      tax_override: { is_shipping: false,
                                      rate: 11,
                                      collection_id: @collection.id} }
    end

    assert_redirected_to admin_tax_override_path(assigns(:shipping_country))
  end


  test "should not create tax override" do
    assert_no_difference('MagazCore::TaxOverride.count') do
      post :create, { shipping_country_id: @shipping_country.id,
                      tax_override: { is_shipping: true,
                                      rate: "",
                                      collection_id: ""} }
    end

    assert_redirected_to admin_tax_override_path(assigns(:shipping_country))
  end
end