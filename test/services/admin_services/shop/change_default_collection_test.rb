require 'test_helper'

class AdminServices::Shop::ChangeDefaultCollectionTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @collection = create(:collection, shop: @shop)
    @success_params = {collection_id: @collection.id, id: @shop.id}
  end

  test 'should update shop with valid params' do
    service = AdminServices::Shop::ChangeDefaultCollection.run(@success_params)
    assert service.valid?
    assert_equal @collection.id, service.result.eu_digital_goods_collection_id
  end

  test 'should not update shop with blank params' do
    service = AdminServices::Shop::ChangeDefaultCollection
                .run(id: '', collection_id: '')
    refute service.valid?
    assert_equal 2, service.errors.full_messages.count
    assert_equal 'Id is not a valid integer', service.errors.full_messages.first
    assert_equal 'Collection is not a valid integer', service.errors.full_messages.last
  end
end
