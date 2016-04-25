require 'test_helper'

class MagazCore::AdminServices::Collection::DeleteCollectionTest < ActiveSupport::TestCase

  def setup
    @shop = create(:shop, name: "shop_name")
    @collection = create(:collection, shop: @shop)
  end

  test 'should delete collection with valid id' do
    assert MagazCore::Collection.find_by_id(@collection.id)
    service = MagazCore::AdminServices::Collection::DeleteCollection
                .run(id: @collection.id.to_s, shop_id: @shop.id)
    assert service.valid?
    refute MagazCore::Collection.find_by_id(@collection.id)
    assert_equal 0, MagazCore::Collection.count
  end

  test 'should not delet collection with blank id' do
    service = MagazCore::AdminServices::Collection::DeleteCollection.run(id: '', shop_id: '')
    refute service.valid?
    assert_equal 1, service.errors.count
    assert_equal 1, MagazCore::Collection.count
  end

end
