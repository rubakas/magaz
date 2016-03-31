require 'test_helper'

module MagazCore
  class ShopServices::AddLinkTest < ActiveSupport::TestCase

    setup do
      @shop = create(:shop, name: 'shop_name')
      @link_list = create(:link_list, shop: @shop)
      @success_params = { name: "Test name", link_list_id: @link_list.id,
                          position: "position", link_type: "link_type"}
      @blank_params =   { name: '', link_list_id: '',
                          position: '', link_type: '' }
    end

    test 'should create link with valid params' do
      service = MagazCore::ShopServices::AddLink.run(@success_params)
      assert service.valid?
      assert MagazCore::Link.find_by_id(service.result.id)
      assert_equal 'Test name', service.result.name
      assert_equal 1, @link_list.links.count
    end

    test 'should not create link with same params' do
      service = MagazCore::ShopServices::AddLink.run(@success_params)
      assert service.valid?

      service2 = MagazCore::ShopServices::AddLink.run(@success_params)
      refute service2.valid?
      assert_equal 1, @link_list.links.count
      assert_equal 1, service2.errors.full_messages.count
      assert_equal "Name has already been taken", service2.errors.full_messages.last
    end

    test 'should not create link with blank params' do
      service = MagazCore::ShopServices::AddLink.run(@blank_params)
      refute service.valid?
      assert_equal 1, service.errors.full_messages.count
      assert_equal 0, @link_list.links.count
    end
  end
end