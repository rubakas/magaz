require 'test_helper'

class Shop::CartsControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

  test "should post add" do
    post :add
    assert_response :success
  end

end
