require 'test_helper'

class Admin::DashboardStoriesTest < ActionDispatch::IntegrationTest
	test "dashboard index" do
    login_as shop_name: 'Example',
      email: 'admin@example.com',
      password: 'password'
		visit '/admin'
    assert page.has_content? 'Dashboard'
	end
end
