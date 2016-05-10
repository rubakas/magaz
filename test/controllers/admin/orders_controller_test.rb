require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @shop = create(:shop, subdomain: 'example')
    @user = create(:user, shop: @shop)
    session_for_user @user
    @customer = create(:customer, shop: @shop)
    @checkout = create(:checkout, customer: @customer)
    @order = create(:checkout, customer: @customer, status: MagazCore::Checkout::STATUSES.first)
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

  test "should update order" do
    patch :update, id: @order, order: { status: @order.status }
    assert_redirected_to order_path(assigns(:order))
  end

end
