require 'test_helper'

class AdminServices::Product::AddProductTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: "New shop")
    @collection = create(:collection, shop: @shop)
    @image =  Rack::Test::UploadedFile.new(File.join(Rails.root, 'test', 'fixtures',
                                                                 'files', 'tapir.jpg'))
    @not_image = Rack::Test::UploadedFile.new(File.join(Rails.root, 'test', 'fixtures',
                                                                     'files', 'test.txt'))
    @success_params = {'price' => "10",
                       'name' => "T-shirt",
                       'handle' => "clothes",
                       'page_title' => "Red T-shirt",
                       'description' => "Red T-shirt",
                       'meta_description' => "T-shirt",
                       'collection_ids' => [@collection.id],
                       'product_images_attributes' => {"0" => {'image' => @image}}}

    @blank_params = {}
  end

  test "should create product with valid params" do
    assert_equal 0, Product.count
    service = AdminServices::Product::AddProduct
              .new(shop_id: @shop.id, params: @success_params)
              .run
    assert service.success?
    assert Product.find(service.result.id)
    assert_equal 1, Product.count
  end

  test "should not create product with same name" do
    assert_equal 0, Product.count
    service = AdminServices::Product::AddProduct
              .new(shop_id: @shop.id, params: @success_params)
              .run
    assert service.success?
    not_valid_service = AdminServices::Product::AddProduct
                        .new(shop_id: @shop.id, params: @success_params)
                        .run
    refute not_valid_service.success?
    assert_equal "Name has already been taken", not_valid_service.errors.last
    assert_equal 1, Product.count
  end

  test "should not create product with blank params" do
    assert_equal 0, Product.count
    service = AdminServices::Product::AddProduct
              .new(shop_id: @shop.id, params: @blank_params)
              .run
    refute service.success?
    assert_equal 1, service.errors.count
    assert_equal "Name can't be blank", service.errors.first
    assert_equal 0, Product.count
  end

  test "should create product with some blank params" do
    valid_params = {
                     'name' => "T-shirt",
                     'description' => "",
                     'price' => nil,
                     'page_title' => "",
                     'meta_description' => "",
                     'handle' => "",
                     'product_images_attributes' => nil,
                     'collection_ids' => nil
                   }
    assert_equal 0, Product.count
    service = AdminServices::Product::AddProduct
              .new(shop_id: @shop.id, params: valid_params)
              .run
    assert service.success?
    assert Product.find(service.result.id)
    assert_equal 1, Product.count
  end

  test "should not create product with invalid image" do
    invalid_params = @success_params.merge({ 'product_images_attributes' => { "0" => { "image" => @not_image } } })
    assert_equal 0, Product.count
    service = AdminServices::Product::AddProduct
              .new(shop_id: @shop.id, params: invalid_params)
              .run
    refute service.success?
    assert_equal 2, service.errors.count
    assert_includes service.errors, "Image can't be blank"
    assert_includes service.errors, "Image You are not allowed to upload \"txt\" files, allowed types: jpg, jpeg, gif, png"
    assert_equal 0, Product.count
  end
end
