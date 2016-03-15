require 'test_helper'

module MagazCore
  class ShopServices::ChangeCollectionTest < ActiveSupport::TestCase

    setup do
      @shop = create(:shop, name: 'shop_name')
      @collection = create(:collection, shop: @shop)
      @collection2 = create(:collection, shop: @shop)
      @success_params = { collection: @collection, name: "Changed name", shop_id: @shop.id,
                          page_title: "Changed page_title", handle: "Changed handle",
                          meta_description: "Changed meta_description", description: "Test description" }
    end

    test 'should update collection with valid params' do
      service = MagazCore::ShopServices::ChangeCollection.run(@success_params)
      assert service.valid?
      assert_equal "Changed page_title", MagazCore::Collection.find(@collection.id).page_title
      assert_equal 'Changed name', MagazCore::Collection.find(@collection.id).name
      assert_equal "Changed handle", MagazCore::Collection.find(@collection.id).handle
    end

    test 'should not update collection with existing name' do
      service = MagazCore::ShopServices::ChangeCollection.
                  run(collection: @collection, name: @collection2.name, shop_id: @shop.id,
                      page_title: "Changed page_title", handle: "Changed handle",
                      meta_description: "Changed meta_description", description: "description")
      refute service.valid?
      assert_equal 1, service.errors.full_messages.count
      assert_equal "Name has already been taken", service.errors.full_messages.first
    end

    test 'should update collection with some blank params' do
      service = MagazCore::ShopServices::ChangeCollection.
                  run(collection: @collection2, name: @collection2.name, shop_id: @shop.id,
                      page_title: '', handle: '', meta_description: '', description: '')
      assert service.valid?
      assert_equal '', service.result.handle
      assert_equal '', service.result.page_title
    end
  end
end