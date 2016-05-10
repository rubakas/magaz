require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  setup do
    @shop = create(:shop, subdomain: 'example')
    @user = create(:user, shop: @shop)
    session_for_user @user
  end

  test "should get index" do
    get :index
    assert_response :success
  end
end
