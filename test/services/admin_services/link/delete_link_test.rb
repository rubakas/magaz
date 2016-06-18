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
              .run( id: @link.id,
                    link_list_id: "#{@link_list.id}")
    assert service.valid?
    assert_equal 0, Link.count
  end

  test 'should not delete link with blank id' do
    assert_equal 1, Link.count
    service = AdminServices::Link::DeleteLink.run(id: '', link_list_id: "#{@link_list.id}")
    refute service.valid?
    assert_equal 1, service.errors.count
    assert_equal "Id is not a valid integer", service.errors.full_messages.first
    assert_equal 1, Link.count
  end
end
