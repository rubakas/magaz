Given(/^store exists$/) do
	@shop = create(:shop, name:'example', subdomain: 'example', password: 'password', email: 'admin@example.com')
end

Given(/^default collection exists$/) do
	@collection = create(:collection, shop: @shop, name: 'Frontpage')
end

Given(/^default collection has products in it$/) do
	@product = create(:product, shop: @shop, collections: [@collection])
end

Given(/^customer browsing store domain$/) do
	host = "#{@shop.subdomain}.#{HOSTNAME}"
	Capybara.app_host = "http://" + host
  Capybara.default_host = Capybara.app_host
end


Given(/^customer visits index page$/) do
  visit "/"
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

Given(/^must be on cart page$/) do
	assert page.has_content? 'Shopping cart'
end

Given(/^customer visits cart page$/) do
  visit "/cart"
end

Given(/^must see empty cart$/) do
  assert page.has_content? 'Your shopping cart is empty.'
end

Given(/^must see product in the cart$/) do
  assert page.has_content? @product.name
end