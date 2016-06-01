require 'test_helper'

class ThemeStore::ThemesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get theme_store_themes_index_url
    assert_response :success
  end

end
