require 'test_helper'

class Admin::ProductsStoriesTest < ActionDispatch::IntegrationTest
  setup do 
    login
    @product = create(:product, shop: @shop)
    click_link 'Products'
  end

  test "products list" do
    assert page.has_content? 'Products'
    assert page.has_content? @product.name
  end

  test "create product" do
    click_link 'Add Product'
    fill_in 'Name', with: 'Some Uniq Product'
    fill_in 'Description', with: ''
    click_button 'Create Product'
    assert page.has_content? 'Product was successfully created.'
  end

  test "create product failure" do
    click_link 'Add Product'
    fill_in 'Name', with: ''
    fill_in 'Description', with: ''
    click_button 'Create Product'
    assert page.has_content? '1 error prohibited this product from being saved'
  end

  test 'create/update product - set product images' do
    skip
  end

  test 'create/update product - set collection membership' do
    skip
  end

  test "edit product" do
    click_link(@product.name, match: :first)
    fill_in 'Name', with: 'Updated Product'
    fill_in 'Description', with: 'Updated Description'
    click_button 'Update Product'
    assert page.has_content? 'Product was successfully updated.'
  end
 
  test "delete product" do
    assert page.has_content? @product.name
    click_link('Delete', match: :first)
    assert page.has_content? "You have no products yet, let's create one!"
  end
end
