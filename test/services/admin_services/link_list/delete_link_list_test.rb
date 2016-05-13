require "test_helper"

class AdminServices::LinkList::DeleteLinkListTest < ActiveSupport::TestCase

  def setup
    @shop = create(:shop, name: "shop name")
    @link_list = create(:link_list, shop: @shop)
    @link = create(:link, link_list: @link_list)
  end

  test 'should delete link list with valid id' do
    service = AdminServices::LinkList::DeleteLinkList.run(id: @link_list.id.to_s,
                                                                     shop_id: @shop.id)
    assert service.valid?
    assert_equal 0, LinkList.count
  end

  test 'should not delete link list with blank id' do
    service = AdminServices::LinkList::DeleteLinkList.run(id: '', shop_id: '')
    refute service.valid?
    assert_equal 1, LinkList.count
  end

  test 'should delete links with link list' do
    assert_difference('Link.count', -1) do
      service = AdminServices::LinkList::DeleteLinkList.run(id: @link_list.id.to_s,
                                                                       shop_id: @shop.id)
    end
  end
end
