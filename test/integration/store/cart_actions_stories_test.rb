require 'test_helper'

class Store::CartActionsStoriesTest < ActionDispatch::IntegrationTest
  setup do
    set_subdomain(@shop.subdomain)
    @collection = create(:collection, shop: @shop, name: 'Frontpage')
    @product = create(:product, shop: @shop, collections: [@collection])
  end

  test "change number of products in cart" do
    visit '/'
    click_link @product.name
    
    click_button "Purchase"
    assert page.has_content? 'Shopping cart'
    assert page.has_content? @product.name
    
    within('#edit_cart') do
      fill_in "cart[updates][#{@product.id}]", :with => '42'
      click_on 'update'
    end
  end

  test "checkout - place order" do
    visit '/'
    click_link @product.name
    
    click_button "Purchase"
    assert page.has_content? 'Shopping cart'
    assert page.has_content? @product.name
    
    within('#edit_cart') do
      fill_in "cart[updates][#{@product.id}]", :with => '42'
      click_on 'checkout'
    end

    assert page.has_content? 'Checkout'
  end

end