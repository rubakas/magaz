require 'test_helper'

class DashboardStoriesTest < ActionDispatch::IntegrationTest

  test "dashboard index" do
    login
    visit '/admin'
    assert page.has_content? 'Dashboard'
  end

end