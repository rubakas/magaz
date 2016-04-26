require "test_helper"

class MagazCore::AdminServices::Page::DeletePageTest < ActiveSupport::TestCase

  def setup
    @shop = create(:shop, name: "shop name")
    @page = create(:page, shop: @shop)
  end

  test "should delete page with valid id" do
    service = MagazCore::AdminServices::Page::DeletePage.run(id: @page.id.to_s,
                                                             shop_id: @shop.id)
    assert service.valid?
    assert_equal 0, MagazCore::Page.count
  end

  test "should not delete page with blank id" do
    service = MagazCore::AdminServices::Page::DeletePage.run(id: '', shop_id: '')
    refute service.valid?
    assert_equal 1, service.errors.count
    assert_equal 1, MagazCore::Page.count
  end
end
