require 'test_helper'

class Shop::CartActionsStoriesTest < ActionDispatch::IntegrationTest
  setup do
    shop = shops(:shop_1)
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
    click_link products(:product_1).name
    
    click_button "Purchase"
    assert page.has_content? 'Shopping cart'
    assert page.has_content? products(:product_1).name
  end

  test "remove product from cart" do
    skip
  end

  test "change number of products in cart" do
    skip
  end

  test "checkout - place order" do
    skip
  end

end