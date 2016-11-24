require 'test_helper'

class Store::ShoppingCartStoriesTest < ActionDispatch::IntegrationTest
  setup do
    login
    @customer   = create(:customer,   shop: @shop)
    @collection = create(:collection, name: "Frontpage", shop: @shop)
    @product    = create(:product, collection_ids: @collection.id, shop: @shop)
    @product2   = create(:product, collection_ids: @collection.id, shop: @shop)
    visit "/"
  end

  test "should visit store with products" do
    assert page.has_content? "Store::Welcome#index"
    assert page.has_content? @product.name
    assert page.has_content? @product2.name
  end

  test "should add product to cart" do
    click_link @product.name
    click_button "Purchase"
    click_button "Update cart"
    assert page.has_content? "Your shopping cart is NOT empty."
  end

  test "from shopping cart to order" do
    click_link @product.name
    click_button "Purchase"
    click_button "Update cart"
    assert page.has_content? "Your shopping cart is NOT empty."
    click_button "Checkout"
    fill_in "Email", with: "example@mail.com"
    click_button "next step"
    assert page.has_content? @product.name
    assert page.has_content? 1
    click_button "complete your purchase"
    assert page.has_content? "Order"
  end

end
