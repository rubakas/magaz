require 'test_helper'

class AdminServices::Link::ChangeLinkTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @link_list = create(:link_list, shop: @shop)
    @link = create(:link, link_list: @link_list)
    @link2 = create(:link, link_list: @link_list)
    @success_params = {
      'name'      => "Test name",
      'link_type' => "Test type",
      'position'  => "2"
    }

    @blank_params = {
      'name'      => "Changed name",
      'position'  => '123',
      'link_type' => ''
    }
  end

  test 'should update link with valid params' do
    service = AdminServices::Link::ChangeLink
              .new( id:           @link.id,
                    link_list_id: @link_list.id,
                    params:       @success_params)
              .run
    assert service.success?
    assert_equal 'Test name', Link.find(@link.id).name
    assert_equal "Test type", Link.find(@link.id).link_type
  end

  test 'should not update link with existing name' do
    invalid_params = @success_params.merge({ 'name' => @link2.name })
    service = AdminServices::Link::ChangeLink
              .new( id:           @link.id,
                    link_list_id: @link_list.id,
                    params:       invalid_params)
              .run
    refute service.success?
    assert_equal 1, service.result.errors.full_messages.count
    assert_equal "Name has already been taken", service.result.errors.full_messages.first
  end

  test 'should update link with some blank params' do
    service = AdminServices::Link::ChangeLink
              .new( id:           @link.id,
                    link_list_id: @link_list.id,
                    params:       @blank_params)
              .run
    assert service.success?
    assert_equal 123, service.result.position
    assert_equal '', service.result.link_type
    assert_equal "Changed name", service.result.name
  end
end
