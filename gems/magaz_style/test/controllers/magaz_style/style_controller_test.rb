require 'test_helper'

module MagazStyle
  class StyleControllerTest < ActionController::TestCase
    test "should get index" do
      get :index
      assert_response :success
    end

  end
end
