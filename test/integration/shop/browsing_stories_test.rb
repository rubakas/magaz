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

  test "product page" do
    visit '/'
    click_link products(:product_1).name
    
    assert page.has_content? products(:product_1).name
    assert page.has_content? products(:product_1).description
    assert page.has_selector? "input[type=submit][value='Purchase']"
  end

  test "collection page" do
    skip
  end

  test "navigation" do
    skip
  end
end
