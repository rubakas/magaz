require 'test_helper'

class Shop::WelcomeControllerTest < ActionController::TestCase
  setup do
    controller_with_subdomain shops(:shop_1).subdomain
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
