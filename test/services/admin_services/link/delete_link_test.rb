require "test_helper"

class AdminServices::Link::DeleteLinkTest < ActiveSupport::TestCase

  def setup
    @shop = create(:shop, name: "shop name")
    @link_list = create(:link_list, shop: @shop)
    @link = create(:link, link_list: @link_list)
  end

  test 'should delete link with valid id' do
    assert_equal 1, Link.count
    service = AdminServices::Link::DeleteLink
              .new(id: @link.id, link_list_id: @link_list.id)
              .run
    assert service.success?
    assert_equal 0, Link.count
  end
end
