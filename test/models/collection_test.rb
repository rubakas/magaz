require 'test_helper'

class CollectionTest < ActiveSupport::TestCase
  test 'validation scenarios' do
    skip # include uniquness scope tests
  end

  test 'two collections with same handle and different shops' do
    @shop1 = create(:shop, name: "shop1")
    @shop2 = create(:shop, name: "shop2")
    @collection1 = create(:collection, name: "collection", handle: "collection-handle", shop: @shop1)

    @collection2 = @shop2.collections.new(name: "collection", handle: "collection-handle")

    assert @collection2.save
    assert @collection1.slug == @collection2.slug
  end

  test 'two collections with same handle and same shop' do
    @shop1 = create(:shop, name: "shop1")

    @collection1 = create(:collection, name: "collection1", handle: "collection-handle", shop: @shop1)

    @collection2 = @shop1.collections.new(name: "collection2", handle: "collection-handle")
    @collection2.save

    assert @collection2.save
    refute @collection1.slug == @collection2.slug
  end
end
