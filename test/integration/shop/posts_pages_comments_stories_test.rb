require 'test_helper'

class Shop::PostsPagesCommentsStoriesTest < ActionDispatch::IntegrationTest
  setup do
    shop = shops(:shop_1)
    set_subdomain(shop.subdomain)
  end

  test "page read" do
    skip
  end

  test "blog article list" do
    skip
  end

  test "blog article read" do
    skip
  end

  test "blog article comment" do
    skip
  end
end