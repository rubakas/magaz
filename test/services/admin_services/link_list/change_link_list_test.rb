require 'test_helper'

class AdminServices::ChangeLinkListTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @link_list = create(:link_list, shop: @shop)
    @link_list2 = create(:link_list, shop: @shop, handle: "existing handle")
    @success_params = { id: "#{@link_list.id}", name: "Test name",
                        shop_id: @shop.id, handle: "Test handle" }
  end

  test 'should update link_list with valid params' do
    service = AdminServices::LinkList::ChangeLinkList.run(@success_params)
    assert service.valid?
    assert_equal 'Test name', LinkList.find(@link_list.id).name
    assert_equal "Test handle", LinkList.find(@link_list.id).handle
  end

  test 'should not update link_list with existing name' do
    service = AdminServices::LinkList::ChangeLinkList.
                run(id: "#{@link_list.id}", name: @link_list2.name,
                    shop_id: @shop.id, handle: "Changed handle")
    refute service.valid?
    assert_equal 1, service.link_list.errors.full_messages.count
    assert_equal "Name has already been taken", service.link_list.errors.full_messages.first
  end

  test 'should not update link_list with existing handle' do
    service = AdminServices::LinkList::ChangeLinkList
              .run( id: "#{@link_list.id}",
                    name: "New name",
                    shop_id: @shop.id,
                    handle: @link_list2.handle)
    refute service.valid?
    assert_equal 1, service.link_list.errors.full_messages.count
    assert_equal "Handle has already been taken", service.link_list.errors.full_messages.first
  end

  test 'should update link_list with blank handle' do
    service = AdminServices::LinkList::ChangeLinkList
              .run( id: "#{@link_list.id}",
                    name: "Changed name",
                    shop_id: @shop.id,
                    handle: "")
    assert service.valid?
    assert_equal '', service.result.handle
    assert_equal "Changed name", service.result.name
  end
end
