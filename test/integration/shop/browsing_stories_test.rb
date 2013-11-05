require 'test_helper'

class Shop::BrowsingStoriesTest < ActionDispatch::IntegrationTest
  setup do
    shop = shops(:shop_1)
    set_subdomain(shop.subdomain)
  end

  test "index page" do
    visit '/'
    assert page.has_content? products(:product_1).name
  end
end
