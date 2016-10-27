require 'test_helper'

class AdminServices::Product::ChangeProductTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: "New shop")
    @product = create(:product, shop: @shop)
    @collection = create(:collection, shop: @shop)
    @image =  Rack::Test::UploadedFile.new(File.join(Rails.root, 'test', 'fixtures',
                                                                 'files', 'tapir.jpg'))
    @success_params = {price: "10",
                       name: "T-shirt",
                       handle: "clothes",
                       page_title: "Red T-shirt",
                       description: "Red T-shirt",
                       meta_description: "T-shirt",
                       collection_ids: [@collection.id],
                       product_images_attributes: {"0" => {image: @image}}}

    @invalid_params = {price: "", name: ""}

    @blank_params = {name: "", shop_id: "", description: "", price: "", page_title: "",
                     meta_description: "",handle: "", product_images_attributes: nil,
                     collection_ids: [] }
  end

  test "should change product with valid params" do
    assert_equal 1, Product.count
    service = AdminServices::Product::ChangeProduct
              .new(id: @product.id, shop_id: @shop.id, params: @success_params)
              .run
    assert service.success?
    assert Product.find(service.result.id)
    assert_equal 1, Product.count
  end

  test "should remove product image" do
    AdminServices::Product::ChangeProduct
              .new(id: @product.id, shop_id: @shop.id, params: @success_params)
              .run
    service = AdminServices::Product::ChangeProduct
                        .new(id: @product.id,
                             shop_id: @shop.id,
                             params: { product_images_attributes: {"0"=>{"_destroy"=>"1",
                                                                         "id"=> @product.product_images.first.id
                                                                         }}})
                        .run
    assert service.success?
    assert Product.find(service.result.id)
    assert_equal [], service.result.product_images
  end

  test "should not change product with invalid params" do
    assert_equal 1, Product.count
    service = AdminServices::Product::ChangeProduct
              .new(id: @product.id, shop_id: @shop.id, params: @invalid_params)
              .run
    refute service.success?
    assert_includes service.errors, "Name can't be blank"
  end

  test "should rise exeption with no params" do
    assert_raises ActiveRecord::RecordNotFound do
      AdminServices::Product::ChangeProduct.new.run
    end
  end
end
