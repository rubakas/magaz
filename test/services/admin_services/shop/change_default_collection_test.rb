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
    assert_equal @collection.id, service.shop.eu_digital_goods_collection_id
  end

  test 'should update shop with only shop_id parameter' do
    service = AdminServices::Shop::ChangeDefaultCollection
              .new(id: @shop.id, collection_id: '')
              .run
    assert service.success?
    assert_equal nil, service.shop.eu_digital_goods_collection_id
  end

  test 'should raise exeption if shop not found' do
    assert_raises ActiveRecord::RecordNotFound do
      service = AdminServices::Shop::ChangeDefaultCollection
                .new(id: '', collection_id: '')
                .run
    end
  end

  test "should not update shop with invalid collection" do
    service = AdminServices::Shop::ChangeDefaultCollection
              .new(id: @shop.id, collection_id: "random")
              .run
    refute service.success?
    assert_equal 2, service.errors.count
    assert_equal "Eu digital goods collection is not a number", service.errors.full_messages[0]
    assert_equal 'Collection does not exist in this shop', service.errors.full_messages[1]
  end
end
