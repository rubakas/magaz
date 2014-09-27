require 'test_helper'

module MagazThemeStore
  class ThemesControllerTest < ActionController::TestCase

    setup do
      @controller = MagazThemeStore::ThemesController.new
      @routes = MagazThemeStore::Engine.routes
    end
    
    test "should get install" do
      get :install
      assert_response :success
    end

  end
end
