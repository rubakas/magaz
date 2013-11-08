require 'test_helper'

class Shop::ProductsControllerTest < ActionController::TestCase
  setup do
    session_for_shop shops(:shop_1)
    @product = products(:product_1)
  end

  test "should get show" do
    get :show, id: @product
    assert_response :success
  end

end
