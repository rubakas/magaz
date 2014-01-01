require 'test_helper'

class Admin::DashboardControllerTest < ActionController::TestCase
  setup do
    @shop = create(:shop, subdomain: 'example')
    session_for_shop @shop
  end

  test "should get index" do
    get :index
    assert_response :success
  end
end
