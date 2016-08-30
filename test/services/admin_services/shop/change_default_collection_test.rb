require 'test_helper'

class AdminServices::Shop::ChangeDefaultCollectionTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @collection = create(:collection, shop: @shop)
    @success_params = {collection_id: @collection.id, id: @shop.id}
  end

  test 'should update shop with valid params' do
    service = AdminServices::Shop::ChangeDefaultCollection
              .new(@success_params)
              .run
    assert service.success?
    assert_equal @collection.id, service.result.eu_digital_goods_collection_id
  end

  test 'should not update shop with blank params' do
    service = AdminServices::Shop::ChangeDefaultCollection
              .new(id: '', collection_id: '')
              .run
    refute service.success?
    assert_equal 2, service.errors.count
    assert_equal 'Wrong params for shop', service.errors[:params]
    assert_equal 'Collection does not exist in this shop', service.errors[:collection]
  end
end
