require 'test_helper'

class AdminServices::Collection::ChangeCollectionTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @collection = create(:collection, shop: @shop)
    @collection2 = create(:collection, shop: @shop)
    @success_params = { id: "#{@collection.id}", name: "Changed name", shop_id: @shop.id,
                        page_title: "Changed page_title", handle: "Changed handle",
                        meta_description: "Changed meta_description", description: "Test description" }
  end

  test 'should update collection with valid params' do
    service = AdminServices::Collection::ChangeCollection.run(@success_params)
    assert service.valid?
    assert service.collection
    assert_equal "Changed page_title", Collection.find(@collection.id).page_title
    assert_equal 'Changed name', Collection.find(@collection.id).name
    assert_equal "Changed handle", Collection.find(@collection.id).handle
  end

  test 'should not update collection with existing name' do
    service = AdminServices::Collection::ChangeCollection.
                run(id: "#{@collection.id}", name: @collection2.name, shop_id: @shop.id,
                    page_title: "Changed page_title", handle: "Changed handle",
                    meta_description: "Changed meta_description", description: "description")
    refute service.valid?
    assert_equal 1, service.collection.errors.count
    assert_equal "Name has already been taken", service.collection.errors.full_messages.first
  end

  test 'should update collection with some blank params' do
    service = AdminServices::Collection::ChangeCollection.
                run(id: "#{@collection2.id}", name: @collection2.name, shop_id: @shop.id,
                    page_title: '', handle: '', meta_description: '', description: '')
    assert service.valid?
    assert_equal '', service.result.handle
    assert_equal '', service.result.page_title
  end
end
