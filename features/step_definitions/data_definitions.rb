Given(/^store exists "(.*?)"$/) do |store_name|
  FactoryGirl.create(:shop, name: store_name, subdomain: store_name, password: 'password', email: "admin@#{store_name}.com")
end

Given(/^product exists "(.*?)" in store "(.*?)"$/) do |product_name, store_name|
  @store = Shop.find_by_name(store_name)
  @collection = FactoryGirl.create(:collection, shop: @store, name: 'Frontpage')
  @product = FactoryGirl.create(:product, name: product_name, shop: @store, collections: [@collection])
end