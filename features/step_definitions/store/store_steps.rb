Given(/^store exists$/) do
  steps %[
    * themes exist
  ]

  service = MagazCore::ShopServices::Create
              .call(shop_params: {name: 'example', 
                                  subdomain: 'example', 
                                  password: 'password', 
                                  email: 'admin@example.com'})
  @shop = service.shop
end

Given(/^default collection exists$/) do
  assert_not_nil @shop.collections.where(name: 'Frontpage')
  @collection = @shop.collections.where(name: 'Frontpage').first
end

Given(/^default collection has products in it$/) do
  @product = create(:product, shop: @shop, collections: [@collection])
end

Given(/^browsing store domain$/) do
  host = "#{@shop.subdomain}.#{HOSTNAME}"
  Capybara.app_host = "http://" + host
  Capybara.default_host = Capybara.app_host
end


Given(/^visit shop index page$/) do
  visit "/"
end

Given(/^visit cart page$/) do
  visit "/cart"
end

Given(/^visit product page$/) do
  visit "/products/#{@product.to_param}"
end

Given(/^must see products of default collection$/) do
  assert page.has_content? @product.name
end

Given(/^customer clicks product name$/) do
  click_link @product.name
end

Given(/^must be on product page$/) do
  assert page.has_content? @product.name
  assert page.has_content? @product.description
  assert page.has_selector? "input[type=submit][value='Purchase']"
end

Given(/^customer adds product to cart$/) do
  click_button "Purchase"
end

Given(/^product successfully added to cart$/) do
  steps %{
    * visit product page
    * customer adds product to cart
    * must be on cart page
    * must see product in the cart
  }
end

Given(/^product successfully removed from cart$/) do
  pending
end

Given(/^with product in the cart$/) do
  steps %{
    * visit product page
    * customer adds product to cart
    * must be on cart page
    * must see product in the cart
  }
end

Given(/^must be on cart page$/) do
  assert page.has_content? 'Shopping cart'
end

Given(/^must see empty cart$/) do
  assert page.has_content? 'Your shopping cart is empty.'
end

Given(/^must see product in the cart$/) do
  assert page.has_content? @product.name
end

Given("customer changes quanity of product to $quantity") do |quantity|
  within('#edit_cart') do
    fill_in "cart[updates][#{@product.id}]", :with => quantity
    click_on 'update'
  end
end

Given(/^must see product in the cart with quantity (\d+)$/) do |quantity|
  assert page.has_content? @product.name
  assert page.has_css?(".cart-quantity")
  assert quantity == page.find(".cart-quantity").value
end

Given(/^must see checkout page$/) do
  assert page.has_content? 'Checkout'
end

Given(/^go to checkout$/) do
  click_on 'checkout'
end

Given(/^input customer email$/) do
  within('#edit_checkout') do
    fill_in "checkout[email]", :with => 'email@customer.com'
  end
end

Given(/^continue to next step$/) do
  click_on 'next step'
end

Given(/^choose payment$/) do
  pending
end

Given(/^finish checkout$/) do
  click_on 'complete your purchase'
end

Given(/^order record exists$/) do
  assert @shop.checkouts.orders.length > 0
end

Given(/^customer record exists$/) do
  assert @shop.customers.length > 0
end

Given(/^order notification sent$/) do
  pending # express the regexp above with the code you wish you had
end