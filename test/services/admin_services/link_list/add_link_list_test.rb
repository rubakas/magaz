require 'test_helper'

class AdminServices::LinkList::AddLinkListTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')

    @success_params = {
      'name'    => "Test name",
      'handle'  => "Test handle"
    }
    @blank_params =   {
      'name'    => '',
      'handle'  => ''
    }
  end

  test 'should create link_list with valid params' do
    service = AdminServices::LinkList::AddLinkList
              .new( shop_id:  @shop.id,
                    params:   @success_params)
              .run

    assert service.success?
    assert LinkList.find_by_id(service.result.id)
    assert_equal 'Test name', service.result.name
    assert_equal 1, @shop.link_lists.count
  end

  test 'should not create link_list with same params' do
    service = AdminServices::LinkList::AddLinkList
              .new( shop_id:  @shop.id,
                    params:   @success_params)
              .run

    assert service.success?
    service2 =  AdminServices::LinkList::AddLinkList
                .new( shop_id:  @shop.id,
                      params:   @success_params)
                .run

    refute service2.success?
    assert_equal 1, @shop.link_lists.count
  end

  test 'should not create link_list with blank params' do
    service = AdminServices::LinkList::AddLinkList
              .new( shop_id:  @shop.id,
                    params:   @blank_params)
              .run

    refute service.success?
    assert_equal 1, service.result.errors.full_messages.count
    assert_equal 0, @shop.link_lists.count
  end

end
