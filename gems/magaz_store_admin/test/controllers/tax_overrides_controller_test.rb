module MagazStoreAdmin
  require 'test_helper'

  class TaxOverridesControllerTest < ActionController::TestCase
    setup do
      @shop = create(:shop, subdomain: 'example')
      @user = create(:user, shop: @shop)
      session_for_user @user
      @collection = create(:collection, shop: @shop, handle: "handle1")
      @shop.update_attributes(eu_digital_goods_collection_id: @collection.id)
      @shipping_country = create(:shipping_country, shop: @shop)
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

      assert_redirected_to tax_override_path(assigns(:shipping_country))
    end
  end
end
