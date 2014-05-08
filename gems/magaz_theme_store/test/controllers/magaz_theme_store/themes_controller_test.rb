require 'test_helper'

module MagazThemeStore
  class ThemesControllerTest < ActionController::TestCase
    test "should get install" do
      get :install
      assert_response :success
    end

  end
end
