require "test_helper"

class AdminServices::LinkList::DeleteLinkListTest < ActiveSupport::TestCase

  def setup
    @shop = create(:shop, name: "shop name")
    @link_list = create(:link_list, shop: @shop)
    @link = create(:link, link_list: @link_list)
  end

  test 'should delete link list with valid id' do
    service = AdminServices::LinkList::DeleteLinkList
              .new( id:       @link_list.id,
                    shop_id:  @shop.id)
              .run

    assert service.success?
    assert_equal 0, LinkList.count
  end

  test 'should delete links with link list' do
    assert_difference('Link.count', -1) do
      AdminServices::LinkList::DeleteLinkList
      .new( id:       @link_list.id,
            shop_id:  @shop.id)
      .run
    end
  end
end
