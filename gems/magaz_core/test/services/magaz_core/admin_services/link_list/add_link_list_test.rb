require 'test_helper'

class MagazCore::AdminServices::LinkList::AddLinkListTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @success_params = { name: "Test name", shop_id: @shop.id, handle: "Test handle"}
    @blank_params =   { name: '', shop_id: '', handle: '' }
  end

  test 'should create link_list with valid params' do
    service = MagazCore::AdminServices::LinkList::AddLinkList.run(@success_params)
    assert service.valid?
    assert MagazCore::LinkList.find_by_id(service.result.id)
    assert_equal 'Test name', service.result.name
    assert_equal 1, @shop.link_lists.count
  end

  test 'should not create link_list with same params' do
    service = MagazCore::AdminServices::LinkList::AddLinkList.run(@success_params)
    assert service.valid?

    service2 = MagazCore::AdminServices::LinkList::AddLinkList.run(@success_params)
    refute service2.valid?
    assert_equal 1, @shop.link_lists.count
    assert_equal 1, service2.errors.full_messages.count
    assert_equal "Name has already been taken", service2.errors.full_messages.last
  end

  test 'should not create link_list with blank params' do
    service = MagazCore::AdminServices::LinkList::AddLinkList.run(@blank_params)
    refute service.valid?
    assert_equal 1, service.errors.full_messages.count
    assert_equal 0, @shop.link_lists.count
  end
end
