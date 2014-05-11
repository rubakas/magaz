require 'test_helper'

module MagazStore
  class CartsControllerTest < ActionController::TestCase
    setup do
      @shop = create(:shop, subdomain: 'example')
      session_for_shop @shop
      @product = create(:product, shop: @shop)
    end

    test "should get show" do
      get :show, use_route: :magaz_store
      assert_response :success
    end

    test "should post add" do
      post :add, { product_id: @product.id, use_route: :magaz_store }
      assert_response :redirect
    end

  end
end