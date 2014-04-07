Given(/^store exists$/) do
	@shop = create(:shop, name:'example', subdomain: 'example', password: 'password', email: 'admin@example.com')
end

Given(/^default collection exists$/) do
	@collection = create(:collection, shop: @shop, name: 'Frontpage')
end

Given(/^default collection has products in it$/) do
	@product = create(:product, shop: @shop, collections: [@collection])
end

Given(/^customer visits index page$/) do
	host = "#{@shop.subdomain}.#{HOSTNAME}"
	Capybara.app_host = "http://" + host
  Capybara.default_host = Capybara.app_host
  visit "/"
end

Given(/^must see products of default collection$/) do
	assert page.has_content? @product.name
end