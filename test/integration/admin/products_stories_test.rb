require 'test_helper'

class Admin::ProductsStoriesTest < ActionDispatch::IntegrationTest
  setup do 
    login_as shop_name: 'Example',
      email: 'admin@example.com',
      password: 'password'
    click_link 'Products'
  end

  test "products list" do
    assert page.has_content? 'Products'
    #page.save_screenshot('screenshot.png')
    assert page.has_content? 'Product 1'
  end

  test "create product" do
    click_link 'New Product'
    fill_in 'Name', with: 'Some Product'
    fill_in 'Description', with: 'Some Description'
    click_button 'Create Product'
    assert page.has_content? 'Product was successfully created.'
  end

  test "edit product" do
    click_link('Edit',match: :first)
    fill_in 'Name', with: 'Some Product'
    fill_in 'Description', with: 'Some Description'
    click_button 'Update Product'
    assert page.has_content? 'Product was successfully updated.'
  end
 
  test "delete product" do
    click_link('Destroy',match: :first)
    page.evaluate_script('window.confirm = function() { return true; }')
    refute page.has_content? 'Product 1'
  end
end
