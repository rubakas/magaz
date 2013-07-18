require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  setup do
    @registration = shops(:one)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create registration" do
    assert_difference('Shop.count') do
      post :create, registration: {  }
    end

    assert_redirected_to root_path(assigns(:registration))
  end
  
end
