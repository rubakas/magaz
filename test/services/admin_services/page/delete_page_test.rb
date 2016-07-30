require "test_helper"

class AdminServices::Page::DeletePageTest < ActiveSupport::TestCase

  def setup
    @shop = create(:shop, name: "shop name")
    @page = create(:page, shop: @shop)
  end

  test "should delete page with valid id" do
    service = AdminServices::Page::DeletePage
              .new(id: @page.id, shop_id: @shop.id)
              .run
    assert service.success?
    assert_equal 0, Page.count
  end
end
