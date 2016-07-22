require 'test_helper'

class AdminServices::Collection::AddCollectionTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @collection = create(:collection, shop: @shop)
    @success_params = { name: "Test name", page_title: "Test page_title",
                        handle: "Test handle", meta_description: "Test meta_description", description: "Test description" }
    @blank_params =   { name: '', page_title: '',
                        handle: '', meta_description: '', description: '' }
  end

  test 'should create collection with valid params' do
    assert_equal 1, @shop.collections.count
    service = AdminServices::Collection::AddCollection.new(shop_id: @shop.id, params: @success_params).run
    assert service.success?
    assert Collection.find_by_id(service.result.id)
    assert_equal 'Test name', service.result.name
    assert_equal 2, @shop.collections.count
  end

  test 'should not create collection with same params' do
    service = AdminServices::Collection::AddCollection.new(shop_id: @shop.id, params: @success_params).run
    assert service.success?
    assert_equal 2, @shop.collections.count

    service2 = AdminServices::Collection::AddCollection.new(shop_id: @shop.id, params: @success_params).run
    refute service2.success?
    assert_equal 2, @shop.collections.count
    assert_equal 2, service2.result.errors.full_messages.count
    assert_equal "Name has already been taken",
                 service2.result.errors.full_messages.first
    assert_equal "Handle has already been taken",
                 service2.result.errors.full_messages.last
  end

  test 'should not create collection with blank params' do
    assert_equal 1, @shop.collections.count
    service = AdminServices::Collection::AddCollection.new(shop_id: @shop.id, params: @blank_params).run
    refute service.success?
    assert_equal 1, service.result.errors.full_messages.count
    assert_equal 1, @shop.collections.count
  end
end
