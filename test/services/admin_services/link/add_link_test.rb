require 'test_helper'

class AdminServices::Link::AddLinkTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @link_list = create(:link_list, shop: @shop)
    @success_params = { name: "Test name", position: "1", link_type: "link_type"}
    @blank_params =   { name: '', position: '', link_type: '' }
  end

  test 'should create link with valid params' do
    service = AdminServices::Link::AddLink.new(link_list_id: @link_list.id, params: @success_params).run
    assert service.success?
    assert Link.find_by_id(service.result.id)
    assert_equal 'Test name', service.result.name
    assert_equal 1, @link_list.links.count
  end

  test 'should not create link with same params' do
    service = AdminServices::Link::AddLink.new(link_list_id: @link_list.id, params: @success_params).run
    assert service.success?
    service2 = AdminServices::Link::AddLink.new(link_list_id: @link_list.id, params: @success_params).run
    refute service2.success?
    assert_equal 1, @link_list.links.count
    assert_equal 1, service2.result.errors.full_messages.count
    assert_equal "Name has already been taken", service2.result.errors.full_messages.last
  end

  test 'should not create link with blank params' do
    service = AdminServices::Link::AddLink.new(link_list_id: @link_list.id, params: @blank_params).run
    refute service.success?
    assert_equal 1, service.result.errors.full_messages.count
    assert_equal "Name can't be blank", service.result.errors.full_messages.first
    assert_equal 0, @link_list.links.count
  end
end
