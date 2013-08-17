require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  setup do
    @registration = shops(:shop_1)
  end

  test "should create shop" do
    assert_difference('Shop.count') do
      post :create, shop: { 
        name: 'uniq name', 
        email: 'uniq1@example.com', 
        password: '1234q'
      }
    end
    assert session[:shop_id]
    assert_redirected_to admin_dashboard_path
  end
  
end
