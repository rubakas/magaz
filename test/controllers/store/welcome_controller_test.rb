require 'test_helper'

module Store
  class WelcomeControllerTest < ActionController::TestCase
    setup do
      @shop = create(:shop, subdomain: 'example')
      controller_with_subdomain @shop.subdomain
    end

    test "should get index" do
      get :index
      assert_response :success
    end

  end
end