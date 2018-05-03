# == Schema Information
#
# Table name: collections
#
#  id               :integer          not null, primary key
#  name             :string
#  description      :text
#  shop_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#  handle           :string
#  page_title       :string
#  meta_description :string
#  slug             :string
#  publish_on       :datetime
#  published_at     :datetime
#

require 'test_helper'

class CollectionTest < ActiveSupport::TestCase
  include Shared::VisibilityExamples

  setup do
    setup_visibility_examples(model_class: Collection, factory_name: :collection)
  end

  # associations
  should have_and_belong_to_many(:products)
  should belong_to(:shop)
  should have_many(:tax_overrides)

  # validations
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name).scoped_to(:shop_id)
  should validate_presence_of(:shop_id)


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

    @collection1 = Collection.create(name: "collection1", handle: "collection-handle", shop: @shop1)

    @collection2 = Collection.create(name: "collection2", handle: "collection-handle", shop: @shop1)

    assert @collection2.save
    refute @collection1.slug == @collection2.slug
  end
end
