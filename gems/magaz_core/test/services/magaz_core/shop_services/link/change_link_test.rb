require 'test_helper'

class MagazCore::ShopServices::Link::ChangeLinkTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @link_list = create(:link_list, shop: @shop)
    @link = create(:link, link_list: @link_list)
    @link2 = create(:link, link_list: @link_list)
    @success_params = { id: @link_list.id, name: "Test name",
                        link_list_id: @link_list.id, link_type: "Test type",
                        position: 0 }
  end

  test 'should update link with valid params' do
    service = MagazCore::ShopServices::Link::ChangeLink.run(@success_params)
    assert service.valid?
    assert_equal 'Test name', MagazCore::Link.find(@link_list.id).name
    assert_equal "Test type", MagazCore::Link.find(@link_list.id).link_type
  end

  test 'should not update link with existing name' do
    service = MagazCore::ShopServices::Link::ChangeLink.
                run(id: @link.id, name: @link2.name,
                    link_list_id: @link_list.id, link_type: "Changed type",
                    position: 1111)
    refute service.valid?
    assert_equal 1, service.errors.full_messages.count
    assert_equal "Name has already been taken", service.errors.full_messages.first
  end

  test 'should update link some blank params' do
    service = MagazCore::ShopServices::Link::ChangeLink.
                run(id: @link_list.id, name: "Changed name",
                    link_list_id: @shop.id, position: '123', link_type: '')
    assert service.valid?
    assert_equal 123, service.result.position
    assert_equal '', service.result.link_type
    assert_equal "Changed name", service.result.name
  end
end
