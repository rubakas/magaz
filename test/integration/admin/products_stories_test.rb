require 'test_helper'

class Admin::ProductsStoriesTest < ActionDispatch::IntegrationTest
  test "products list" do
    login_as shop_name: 'Example',
      email: 'admin@example.com',
      password: 'password'
    click_link 'Products'
    assert page.has_content? "Products"
  end
end
