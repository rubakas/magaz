require 'test_helper'

class AdminServices::ProductImage::AddProductImageTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: "shop name")
    @product = create(:product, shop: @shop)
    @image = fixture_file_upload('/files/tapir.jpg', 'image/jpg')
    @not_image = fixture_file_upload('/files/test.txt', 'image/jpg')
    @success_params = { image: @image }
    @blank_params = { image: nil }
  end

  test "should add image with valid params" do
    assert_equal 0, ProductImage.count
    service = AdminServices::ProductImage::AddProductImage
              .new(product_id: @product.id, params: @success_params)
              .run
    assert service.success?
    assert ProductImage.find(service.result.id)
    assert_equal 1, ProductImage.count
  end

  test "should not add image without image" do
    assert_equal 0, ProductImage.count
    service = AdminServices::ProductImage::AddProductImage
              .new(product_id: @product.id, params: @blank_params)
              .run
    refute service.success?
    assert_equal 1, service.result.errors.full_messages.count
    assert_equal "Image can't be blank", service.result.errors.full_messages.first
    assert_equal 0, ProductImage.count
  end

  test "should not create image with wrong extension" do
    invalid_params = { image: @not_image }
    assert_equal 0, ProductImage.count
    service = AdminServices::ProductImage::AddProductImage
              .new(product_id: @product.id, params: invalid_params)
              .run
    refute service.success?
    assert_equal 2, service.result.errors.full_messages.count
    assert_equal "Image You are not allowed to upload \"txt\" files, allowed types: jpg, jpeg, gif, png", service.result.errors.full_messages.first
    assert_equal "Image can't be blank", service.result.errors.full_messages.last
    assert_equal 0, ProductImage.count
  end
end
