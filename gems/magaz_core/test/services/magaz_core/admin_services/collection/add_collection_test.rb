require 'test_helper'

class MagazCore::AdminServices::Collection::AddCollectionTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @collection = create(:collection, shop: @shop)
    @success_params = { name: "Test name", shop_id: @shop.id, page_title: "Test page_title",
                        handle: "Test handle", meta_description: "Test meta_description", description: "Test description" }
    @blank_params =   { name: '', shop_id: '', page_title: '',
                        handle: '', meta_description: '', description: '' }
  end

  test 'should create collection with valid params' do
    assert_equal 1, @shop.collections.count
    service = MagazCore::AdminServices::Collection::AddCollection.run(@success_params)
    assert service.valid?
    assert MagazCore::Collection.find_by_id(service.result.id)
    assert_equal 'Test name', service.result.name
    assert_equal 2, @shop.collections.count
  end

  test 'should not create collection with same params' do
    service = MagazCore::AdminServices::Collection::AddCollection.run(@success_params)
    assert service.valid?
    assert_equal 2, @shop.collections.count

    service2 = MagazCore::AdminServices::Collection::AddCollection.run(@success_params)
    refute service2.valid?
    assert_equal 2, @shop.collections.count
    assert_equal 1, service2.errors.full_messages.count
    assert_equal "Name has already been taken", service2.errors.full_messages.last
  end

  test 'should not create collection with blank params' do
    assert_equal 1, @shop.collections.count
    service = MagazCore::AdminServices::Collection::AddCollection.run(@blank_params)
    refute service.valid?
    assert_equal 1, service.errors.full_messages.count
    assert_equal 1, @shop.collections.count
  end
end
