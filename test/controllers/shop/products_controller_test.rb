require 'test_helper'

class Shop::ProductsControllerTest < ActionController::TestCase
  setup do
    @shop = create(:shop, subdomain: 'example')
    session_for_shop @shop
    @product = create(:product, shop: @shop)
  end

  test "should get show" do
    get :show, id: @product
    assert_response :success
  end

end
