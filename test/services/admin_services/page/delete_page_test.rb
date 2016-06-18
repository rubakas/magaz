require "test_helper"

class AdminServices::Page::DeletePageTest < ActiveSupport::TestCase

  def setup
    @shop = create(:shop, name: "shop name")
    @page = create(:page, shop: @shop)
  end

  test "should delete page with valid id" do
    service = AdminServices::Page::DeletePage.run( id: "#{@page.id}",
                                                   shop_id: @shop.id)
    assert service.valid?
    assert_equal 0, Page.count
  end

  test "should not delete page with blank id" do
    service = AdminServices::Page::DeletePage.run(id: '', shop_id: @shop.id)
    refute service.valid?
    assert_equal 1, service.errors.count
    assert_equal "Id can't be blank", service.errors.full_messages.first
    assert_equal 1, Page.count
  end
end
