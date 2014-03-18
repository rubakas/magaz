require 'test_helper'

class Admin::OrdersControllerTest < ActionController::TestCase
  setup do
    @shop = create(:shop, subdomain: 'example')
    session_for_shop @shop
    @order = create(:order, shop: @shop)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should show order" do
    get :show, id: @order
    assert_response :success
  end

  test "should update product" do
    patch :update, id: @order, order: { status: @order.status }
    assert_redirected_to admin_order_path(assigns(:order))
  end

end