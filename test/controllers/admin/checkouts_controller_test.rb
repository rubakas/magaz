require 'test_helper'

class CheckoutsControllerTest < ActionController::TestCase
  setup do
    @shop = create(:shop, subdomain: 'example')
    @user = create(:user, shop: @shop)
    session_for_user @user
    @customer = create(:customer, shop: @shop)
    @abandoned_checkout = create(:checkout, customer: @customer, email: "Some Uniq Email")
    @subscriber_notification = create(:subscriber_notification, shop: @shop, notification_method: 'email', subscription_address: 'email@some.com')
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:abandoned_checkouts)
  end

  test "should show checkout" do
    get :show, id: @abandoned_checkout
    assert_response :success
  end
end
