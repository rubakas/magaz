require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  setup do
    @registration = shops(:shop_1)
  end

  test "should create shop" do
    @request.host = HOSTNAME
    assert_difference('Shop.count') do
      post :create, shop: { 
        name: 'uniq name', 
        email: 'uniq1@example.com', 
        password: '1234q'
      }
    end
    assert session[:user_id]
    @request.host = "uniq-name.#{HOSTNAME}"
    assert_redirected_to admin_root_path(host: HOSTNAME, subdomain: 'uniq-name')
  end
  
end
