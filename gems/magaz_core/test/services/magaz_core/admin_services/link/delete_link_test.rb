require "test_helper"

class MagazCore::AdminServices::Link::DeleteLinkTest < ActiveSupport::TestCase

  def setup
    @shop = create(:shop, name: "shop name")
    @link_list = create(:link_list, shop: @shop)
    @link = create(:link, link_list: @link_list)
  end

  test 'should delete link with valid id' do
    service = MagazCore::AdminServices::Link::DeleteLink.run(id: @link.id)
    assert service.valid?
    assert_equal 0, MagazCore::Link.count
  end

  test 'should not delete link with blank id' do
    service = MagazCore::AdminServices::Link::DeleteLink.run(id: '')
    refute service.valid?
    assert_equal 1, MagazCore::Link.count
  end
end
