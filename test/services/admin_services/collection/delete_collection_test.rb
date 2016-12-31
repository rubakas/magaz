require 'test_helper'

class AdminServices::Collection::DeleteCollectionTest < ActiveSupport::TestCase

  def setup
    @shop = create(:shop, name: "shop_name")
    @collection = create(:collection, shop: @shop)
  end

  test 'should delete collection with valid id' do
    assert Collection.find_by_id(@collection.id)
    service = AdminServices::Collection::DeleteCollection
                .new( id:       @collection.id.to_s,
                      shop_id:  @shop.id)
                .run
    assert service.success?
    refute Collection.find_by_id(@collection.id)
    assert_equal 0, Collection.count
  end

  test 'should not delete collection with blank id' do
    assert_raises ActiveRecord::RecordNotFound do
      service = AdminServices::Collection::DeleteCollection
                .new( id:       '',
                      shop_id:  '')
                .run
    end
  end

end
