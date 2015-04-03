module MagazStoreAdmin 
require 'test_helper'

module Admin
  class ProductsStoriesTest < ActionDispatch::IntegrationTest

    setup do
      login
      @product = create(:product, shop: @shop)
      @collection1 = create(:collection, name: "test collection 1",
                                         shop: @shop,
                                         handle: "handle1")
      @collection2 = create(:collection, name: "test collection 2",
                                         shop: @shop,
                                         handle: "handle2")
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

    test 'create product with image' do
      click_link 'Add Product'
      fill_in 'Name', with: 'Some Uniq Product'
      fill_in 'Description', with: ''
      attach_file('product_product_images_attributes_0_image', File.join(Rails.root, '/test/fixtures/files/image.jpg'))
      click_button 'Create Product'
      assert page.has_css?('.product_image')
      assert page.has_content? 'Product was successfully created.'
    end

    test 'update product with image' do
      click_link 'Add Product'
      fill_in 'Name', with: 'Some Uniq Product'
      fill_in 'Description', with: ''
      click_button 'Create Product'
      assert page.has_content? 'Product was successfully created.'
      attach_file('product_product_images_attributes_0_image', File.join(Rails.root, '/test/fixtures/files/image.jpg'))
      click_button 'Update Product'
      assert page.has_content? 'Product was successfully updated.'
      assert page.has_css?('.product_image')
    end

    test 'remove image' do
      click_link 'Add Product'
      fill_in 'Name', with: 'Some Uniq Product'
      fill_in 'Description', with: ''
      attach_file('product_product_images_attributes_0_image', File.join(Rails.root, '/test/fixtures/files/image.jpg'))
      click_button 'Create Product'
      page.has_css?('img', text: "thumb_image.jpg")
      assert page.has_content? 'Product was successfully created.'
      check "product_product_images_attributes_0__destroy"
      click_button 'Update Product'
      assert page.has_content? 'Product was successfully updated.'
      assert page.has_no_css?('.product_image')
    end

    test 'create product with collection membership' do
      click_link 'Add Product'
      fill_in 'Name', with: 'Some Uniq Product'
      fill_in 'Description', with: ''
      check 'test collection 1'
      click_button 'Create Product'
      assert page.has_content? 'Product was successfully created.'
      assert has_checked_field?('test collection 1')
    end

    test "update product with collection membership" do
      click_link 'Add Product'
      fill_in 'Name', with: 'Some Uniq Product'
      fill_in 'Description', with: ''
      check 'test collection 1'
      click_button 'Create Product'
      assert page.has_content? 'Product was successfully created.'
      assert has_checked_field?('test collection 1')
      uncheck 'test collection 1'
      check 'test collection 2'
      click_button 'Update Product'
      assert page.has_content? 'Product was successfully updated.'
      assert has_checked_field?('test collection 2')
      assert has_no_checked_field?('test collection 1')
    end

    test "handle url" do
      click_link 'Add Product'
      fill_in 'Name', with: 'Some Uniq Product'
      fill_in 'Description', with: 'Some Uniq Description'
      fill_in 'Handle', with: 'test-url'
      click_button 'Create Product'
      assert page.has_content? 'Product was successfully created.'
      assert current_path == "/admin/products/test-url"
    end

    test "handle url update" do
      click_link 'Add Product'
      fill_in 'Name', with: 'Some Uniq Product'
      fill_in 'Description', with: 'Some Uniq Description'
      fill_in 'Handle', with: 'test-url'
      click_button 'Create Product'
      assert page.has_content? 'Product was successfully created.'
      assert current_path == "/admin/products/test-url"
      fill_in 'Handle', with: 'edit-test-url'
      click_button 'Update Product'
      assert page.has_content? 'Product was successfully updated.'
      assert current_path == "/admin/products/edit-test-url"
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
end
end
