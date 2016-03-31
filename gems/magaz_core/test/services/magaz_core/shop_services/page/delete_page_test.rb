require "test_helper"

module MagazCore
  class ShopServices::DeletePageTest < ActiveSupport::TestCase

    def setup
      @shop = create(:shop, name: "shop name")
      @page = create(:page, shop: @shop)
    end

    test "should delete page with valid id" do 
      service = MagazCore::ShopServices::DeletePage.run(id: @page.id)
      assert service.valid?
      assert_equal 0, MagazCore::Page.count
    end

    test "should not delete page with blank id" do 
      service = MagazCore::ShopServices::DeletePage.run(id: '')
      refute service.valid?
      assert_equal 1, MagazCore::Page.count
    end
  end
end
