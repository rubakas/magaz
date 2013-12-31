require 'test_helper'

class Shop::CartActionsStoriesTest < ActionDispatch::IntegrationTest
  setup do
    shop = create(:shop, subdomain: 'example')
    @product = create(:product, shop: shop)
    Capybara.reset!
    set_subdomain(shop.subdomain)
  end

  test "empty cart" do
    visit shop_cart_path
    assert page.has_content? 'Shopping cart'
    assert page.has_content? 'Your shopping cart is empty.'
  end

  test "add product to cart" do
    visit '/'
    click_link @product.name
    
    click_button "Purchase"
    assert page.has_content? 'Shopping cart'
    assert page.has_content? @product.name
  end

  test "change number of products in cart" do
    visit '/'
    click_link @product.name
    
    click_button "Purchase"
    assert page.has_content? 'Shopping cart'
    assert page.has_content? @product.name
    assert page.has_content? '1'
    
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
    assert page.has_content? '1'
    
    within('#edit_cart') do
      fill_in "cart[updates][#{@product.id}]", :with => '42'
      click_on 'checkout'
    end

    assert page.has_content? 'Checkout'
  end

end