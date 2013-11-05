require 'test_helper'

class Shop::CartActionsStoriesTest < ActionDispatch::IntegrationTest
  setup do
    shop = shops(:shop_1)
    set_subdomain(shop.subdomain)
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