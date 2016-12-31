require 'test_helper'

class AdminServices::ChangeLinkListTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @link_list = create(:link_list, shop: @shop)
    @link_list2 = create(:link_list, shop: @shop, handle: "existing handle")
    @success_params = {
      'name'    => "Test name",
      'handle'  => "Test handle"
    }
    @blank_params = {
      'name'    => "Changed name",
      'handle'  => ""
    }
  end

  test 'should update link_list with valid params' do
    service = AdminServices::LinkList::ChangeLinkList
              .new( id:      @link_list.id,
                    shop_id: @shop.id,
                    params: @success_params)
              .run
    assert service.success?
    assert_equal 'Test name', LinkList.find(@link_list.id).name
    assert_equal "Test handle", LinkList.find(@link_list.id).handle
  end

  test 'should not update link_list with existing name' do
    invalid_params = @success_params.merge({ 'name' => @link_list2.name })
    service = AdminServices::LinkList::ChangeLinkList
              .new( id:       @link_list.id,
                    shop_id:  @shop.id,
                    params:   invalid_params)
              .run
    refute service.success?
    assert_equal 1, service.result.errors.full_messages.count
    assert_equal "Name has already been taken", service.result.errors.full_messages.first
  end

  test 'should update link_list with blank handle' do
    service = AdminServices::LinkList::ChangeLinkList
              .new( id:       @link_list.id,
                    shop_id:  @shop.id,
                    params:   @blank_params)
              .run
    assert service.success?
    assert_equal '', service.result.handle
    assert_equal "Changed name", service.result.name
  end
end
