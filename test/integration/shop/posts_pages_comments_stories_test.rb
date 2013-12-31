require 'test_helper'

class Shop::PostsPagesCommentsStoriesTest < ActionDispatch::IntegrationTest
  setup do
    shop = create(:shop, subdomain: 'example')
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
