require "test_helper"

class MagazCore::AdminServices::Link::DeleteLinkTest < ActiveSupport::TestCase

  def setup
    @shop = create(:shop, name: "shop name")
    @link_list = create(:link_list, shop: @shop)
    @link = create(:link, link_list: @link_list)
  end

  test 'should delete link with valid id' do
    assert_equal 1, MagazCore::Link.count
    service = MagazCore::AdminServices::Link::DeleteLink.run(id: @link.id,
                                                             link_list_id: @link_list.id)
    assert service.valid?
    assert_equal 0, MagazCore::Link.count
  end

  test 'should not delete link with blank id' do
    assert_equal 1, MagazCore::Link.count
    service = MagazCore::AdminServices::Link::DeleteLink.run(id: '', link_list_id: '')
    refute service.valid?
    assert_equal 2, service.errors.count
    assert_equal 1, MagazCore::Link.count
  end
end
