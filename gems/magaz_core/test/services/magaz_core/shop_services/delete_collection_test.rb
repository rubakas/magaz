require 'test_helper'

module MagazCore
  class ShopServices::DeleteCollectionTest < ActiveSupport::TestCase

    def setup
      @shop = create(:shop, name: "shop_name")
      @collection = create(:collection, shop: @shop)
    end

    test 'should delete collection with valid id' do
      service = MagazCore::ShopServices::DeleteCollection.run(id: @collection.id)
      assert service.valid?
      assert_equal 0, MagazCore::Collection.count
    end

    test 'should not delet collection with blank id' do
      service = MagazCore::ShopServices::DeleteCollection.run(id: '')
      refute service.valid?
      assert_equal 1, MagazCore::Collection.count
    end

  end
end