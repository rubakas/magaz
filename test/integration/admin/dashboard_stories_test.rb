require 'test_helper'

module Admin
  class DashboardStoriesTest < ActionDispatch::IntegrationTest
    setup do
      login
      @product = create(:product, shop: @shop)
      visit '/admin'
    end

    test "dashboard index" do
      assert page.has_content? 'Dashboard'
    end
    
  end
end
