require 'test_helper'

class Shop::CartsControllerTest < ActionController::TestCase
  setup do
    session_for_shop shops(:shop_1)
    @product = products(:product_1)
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
