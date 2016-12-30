require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  include Shared::VisibilityExamples

  setup do
    setup_visibility_examples(model_class: Product, factory_name: :product)
  end

  # associations
  should have_and_belong_to_many  :collections
  should have_many                :product_images
  should belong_to                :shop

  #validations
  should validate_presence_of :name
  should validate_uniqueness_of(:name).scoped_to(:shop_id)
  # should validate_numericality_of :price #allow_blank: true
  should validate_presence_of :shop_id

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
