require 'test_helper'

class Shop::CartsControllerTest < ActionController::TestCase
  setup do
    @shop = create(:shop, subdomain: 'example')
    session_for_shop @shop
    @product = create(:product, shop: @shop)
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should post add" do
    post :add, {product_id: @product.id}
    assert_response :redirect
  end

end
