require 'test_helper'

class Admin::CheckoutsControllerTest < ActionController::TestCase
  setup do
    @shop = create(:shop, subdomain: 'example')
    session_for_shop @shop
    @customer = create(:customer, shop: @shop)
    @checkout = create(:checkout, customer: @customer, email: "Some Uniq Email")
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:checkouts)
  end

  test "should show checkout" do
    get :show, id: @checkout
    assert_response :success
  end
end
