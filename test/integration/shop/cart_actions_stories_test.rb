require 'test_helper'

class Shop::CartActionsStoriesTest < ActionDispatch::IntegrationTest
  setup do
    shop = shops(:shop_1)
    set_subdomain(shop.subdomain)
  end

  test "empty cart" do
    visit shop_cart_path
    assert page.has_content? 'Your shopping cart is empty.'
  end

  test "add product to cart" do
    skip
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