require 'test_helper'

class Admin::DashboardControllerTest < ActionController::TestCase
  setup do
    session_for_shop shops(:shop_1)
  end

  test "should get index" do
    get :index
    assert_response :success
  end
end
