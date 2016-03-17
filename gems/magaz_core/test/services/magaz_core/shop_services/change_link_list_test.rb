require 'test_helper'

module MagazCore
  class ShopServices::ChangeLinkListTest < ActiveSupport::TestCase

    setup do
      @shop = create(:shop, name: 'shop_name')
      @link_list = create(:link_list, shop: @shop)
      @link_list2 = create(:link_list, shop: @shop)
      @success_params = { id: @link_list.id, name: "Test name",
                          shop_id: @shop.id, handle: "Test handle" }
    end

    test 'should update link_list with valid params' do
      service = MagazCore::ShopServices::ChangeLinkList.run(@success_params)
      assert service.valid?
      assert_equal 'Test name', MagazCore::LinkList.find(@link_list.id).name
      assert_equal "Test handle", MagazCore::LinkList.find(@link_list.id).handle
    end

    test 'should not update link_list with existing name' do
      service = MagazCore::ShopServices::ChangeLinkList.
                  run(id: @link_list.id, name: @link_list2.name,
                      shop_id: @shop.id, handle: "Changed handle")
      refute service.valid?
      assert_equal 1, service.errors.full_messages.count
      assert_equal "Name has already been taken", service.errors.full_messages.first
    end

    test 'should update link_list with some blank params' do
      service = MagazCore::ShopServices::ChangeLinkList.
                  run(id: @link_list.id, name: "Changed name",
                      shop_id: @shop.id, handle: "")
      assert service.valid?
      assert_equal '', service.result.handle
      assert_equal "Changed name", service.result.name
    end
  end
end