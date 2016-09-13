require 'test_helper'

class AdminServices::Shop::EnableEuDigitalGoodsTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @collection = create(:collection, shop: @shop, handle: "handle1")
    @collection2 = create(:collection, shop: @shop, handle: "handle2")
    @success_params = {collection_name: @collection.name, id: @shop.id}
  end

  test 'should update shop default collection with valid params' do
    service = AdminServices::Shop::EnableEuDigitalGoods
              .new(@success_params)
              .run
    assert service.success?
    assert_equal @collection.id, service.shop.eu_digital_goods_collection_id
  end

  test 'should create new default collection for shop' do
    service = AdminServices::Shop::EnableEuDigitalGoods
              .new(collection_name: 'New name', id: @shop.id)
              .run
    assert service.success?
    assert_not_equal @collection.id, service.shop.eu_digital_goods_collection_id
    assert_not_equal @collection2.id, service.shop.eu_digital_goods_collection_id
    assert_equal 'New name',
                 Collection.find(service.shop.eu_digital_goods_collection_id).name
  end

  test 'should not change eu_digital_goods_collection_id with blank collection name' do
    service = AdminServices::Shop::EnableEuDigitalGoods
              .new(collection_name: '', id: @shop.id)
              .run
    refute service.success?
    assert_equal 1, service.errors.count
    assert_includes service.errors.full_messages, "Collections is invalid"
  end
end
