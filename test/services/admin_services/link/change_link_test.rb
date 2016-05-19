require 'test_helper'

class AdminServices::Link::ChangeLinkTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @link_list = create(:link_list, shop: @shop)
    @link = create(:link, link_list: @link_list)
    @link2 = create(:link, link_list: @link_list)
    @success_params = { id: @link.id, name: "Test name",
                        link_list_id: "#{@link_list.id}", link_type: "Test type",
                        position: "2" }
  end

  test 'should update link with valid params' do
    service = AdminServices::Link::ChangeLink.run(@success_params)
    assert service.valid?
    assert_equal 'Test name', Link.find(@link.id).name
    assert_equal "Test type", Link.find(@link.id).link_type
  end

  test 'should not update link with existing name' do
    service = AdminServices::Link::ChangeLink.
                run(id: @link.id, name: @link2.name,
                    link_list_id: "#{@link_list.id}", link_type: "Changed type",
                    position: "1111")
    refute service.valid?
    assert_equal 1, service.link.errors.full_messages.count
    assert_equal "Name has already been taken", service.link.errors.full_messages.first
  end

  test 'should update link with some blank params' do
    service = AdminServices::Link::ChangeLink.
                run(id: @link.id, name: "Changed name",
                    link_list_id: "#{@link_list.id}", position: '123', link_type: '')
    assert service.valid?
    assert_equal 123, service.result.position
    assert_equal '', service.result.link_type
    assert_equal "Changed name", service.result.name
  end
end
