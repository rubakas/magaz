# == Schema Information
#
# Table name: products
#
#  id               :integer          not null, primary key
#  name             :string
#  description      :text
#  created_at       :datetime
#  updated_at       :datetime
#  shop_id          :integer
#  price            :decimal(38, 2)
#  handle           :string
#  page_title       :string
#  meta_description :string
#  slug             :string
#  publish_on       :datetime
#  published_at     :datetime
#

require 'test_helper'

module MagazCore
  class ProductTest < ActiveSupport::TestCase
    include MagazCore::Shared::VisibilityExamples

    should have_and_belong_to_many(:collections)
    should have_many(:product_images).dependent(:destroy)
    should belong_to(:shop)
    should have_many(:events)
    should accept_nested_attributes_for(:product_images)
    should validate_presence_of(:name)
    should validate_uniqueness_of(:name).scoped_to(:shop_id)

    setup do
      setup_visibility_examples(model_class: MagazCore::Product, factory_name: :product)
    end

    test 'associations' do
      skip
    end

    test 'validation' do
      skip
    end

    test 'two products with same handle and different shops' do
      @shop1 = create(:shop, name: "shop1")
      @shop2 = create(:shop, name: "shop2")
      @product1 = create(:product, name: "product", handle: "product-handle", shop: @shop1)

      @product2 = @shop2.products.new(name: "product", handle: "product-handle")

      assert @product2.save
      assert @product1.slug == @product2.slug
    end

    test 'two products with same handle and same shop' do
      @shop1 = create(:shop, name: "shop1")

      @product1 = create(:product, name: "product1", handle: "product-handle", shop: @shop1)

      @product2 = @shop1.products.new(name: "product2", handle: "product-handle")
      @product2.save

      assert @product2.save
      refute @product1.slug == @product2.slug
    end
  end
end
