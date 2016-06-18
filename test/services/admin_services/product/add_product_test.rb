require 'test_helper'

class AdminServices::Product::AddProductTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: "New shop")
    @collection = create(:collection, shop: @shop)
    @image =  Rack::Test::UploadedFile.new(File.join(Rails.root, 'test', 'fixtures',
                                                                 'files', 'tapir.jpg'))
    @not_image = Rack::Test::UploadedFile.new(File.join(Rails.root, 'test', 'fixtures',
                                                                     'files', 'test.txt'))
    @success_params = {price: "10",
                       name: "T-shirt",
                       handle: "clothes",
                       shop_id: @shop.id,
                       page_title: "Red T-shirt",
                       description: "Red T-shirt",
                       meta_description: "T-shirt",
                       collection_ids: [@collection.id],
                       product_images_attributes: {"0" => {"image" => @image}}}
    @blank_params = {name: "", shop_id: "", description: "", price: "", page_title: "",
                     meta_description: "",handle: "", product_images_attributes: nil,
                     collection_ids: [] }
  end

  test "should create product with valid params" do
    assert_equal 0, Product.count
    service = AdminServices::Product::AddProduct.run(@success_params)
    assert service.valid?
    assert Product.find(service.result.id)
    assert_equal 1, Product.count
  end

  test "should not create product with same name" do
    assert_equal 0, Product.count
    service = AdminServices::Product::AddProduct.run(@success_params)
    assert service.valid?
    not_valid_service = AdminServices::Product::AddProduct.run(@success_params)
    refute not_valid_service.valid?
    assert_equal "Name has already been taken", not_valid_service.errors.full_messages.last
    assert_equal 1, Product.count
  end

  test "should not create product with blank params" do
    assert_equal 0, Product.count
    service = AdminServices::Product::AddProduct.run(@blank_params)
    refute service.valid?
    assert_equal 2, service.errors.full_messages.count
    assert_equal "Shop is not a valid integer", service.errors.full_messages.first
    assert_equal "Price is not a valid decimal", service.errors.full_messages.last
    assert_equal 0, Product.count
  end

  test "should create product with some blank params" do
    assert_equal 0, Product.count
    service = AdminServices::Product::AddProduct
                .run(name: "T-shirt", shop_id: @shop.id, description: "",
                        price: nil, page_title: "", meta_description: "",
                        handle: "", product_images_attributes: nil,
                        collection_ids: nil)
    assert service.valid?
    assert Product.find(service.result.id)
    assert_equal 1, Product.count
  end

  test "should not create product with invalid image" do
    @success_params[:product_images_attributes] = {"0" => {"image" => @not_image}}
    assert_equal 0, Product.count
    service = AdminServices::Product::AddProduct.run(@success_params)
    refute service.valid?
    assert_equal 1, service.errors.full_messages.count
    assert_equal "Image You are not allowed to upload \"txt\" files, allowed types: "+
                    "jpg, jpeg, gif, png", service.errors.full_messages.first
    assert_equal 0, Product.count
  end
end
