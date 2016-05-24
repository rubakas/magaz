require 'test_helper'

module Admin
  class DashboardStoriesTest < ActionDispatch::IntegrationTest
    setup do
      login
      @product = create(:product, shop: @shop)
      @event = create(:event, shop: @shop, subject: @product)
      visit '/admin'
    end

    test "dashboard index" do
      assert page.has_content? 'Dashboard'
      assert page.has_content? "User created a product: /admin/products/#{@product.id}"
      assert page.has_content? @event.created_at
    end

    test "link of event" do
      find(:xpath, "//a[@href='/admin/products/#{@product.id}']").click
      assert page.has_content? 'Editing product'
    end
  end
end