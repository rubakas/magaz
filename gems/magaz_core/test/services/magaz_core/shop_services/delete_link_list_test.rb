require "test_helper"

module MagazCore
  class ShopServices::DeleteLinkListTest < ActiveSupport::TestCase

    def setup
      @shop = create(:shop, name: "shop name")
      @link_list = create(:link_list, shop: @shop)
    end

    test 'should delete link list with valid id' do
      service = MagazCore::ShopServices::DeleteLinkList.run(id: @link_list.id)
      assert service.valid?
      assert_equal 0, MagazCore::LinkList.count
    end

    test 'should not delete link list with blank id' do
      service = MagazCore::ShopServices::DeleteLinkList.run(id: '')
      refute service.valid?
      assert_equal 1, MagazCore::LinkList.count
    end
  end
end