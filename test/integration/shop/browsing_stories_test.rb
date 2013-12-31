require 'test_helper'

class Shop::BrowsingStoriesTest < ActionDispatch::IntegrationTest
  setup do
    shop = create(:shop, subdomain: 'example')
    set_subdomain(shop.subdomain)
    @product = create(:product, shop: shop)
  end

  test "index page" do
    visit '/'
    assert page.has_content? @product.name
  end

  test "product page" do
    visit '/'
    click_link @product.name
    
    assert page.has_content? @product.name
    assert page.has_content? @product.description
    assert page.has_selector? "input[type=submit][value='Purchase']"
  end

  test "collection page" do
    skip
  end

  test "navigation" do
    skip
  end
end
