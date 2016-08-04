require 'test_helper'
class AdminServices::ProductImage::ChangeProductImageTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: "shop name")
    @product = create(:product, shop: @shop)
    @image = fixture_file_upload('/files/tapir.jpg', 'image/jpg')
    @image2 = fixture_file_upload('/files/sell_bg_berlin.jpg', 'image/jpg')
    @not_image = fixture_file_upload('/files/test.txt', 'image/jpg')
    @product_image = create(:product_image, product: @product, image: @image)
    @success_params = { image: @image2 }
    @blank_params = { image: nil }
  end

  test "should update image with valid params" do
    assert_equal 1, ProductImage.count
    service = AdminServices::ProductImage::ChangeProductImage
              .new(id: @product_image.id, params: @success_params, product_id: @product.id)
              .run
    assert service.success?
    assert_equal "sell_bg_berlin.jpg", ProductImage.find(@product_image.id).image.file.filename
  end

  test "should not update image without image" do
    assert_equal 1, ProductImage.count
    service = AdminServices::ProductImage::ChangeProductImage
              .new(id: @product_image.id, params: @blank_params, product_id: @product.id)
              .run
    assert service.success?
    assert_equal "tapir.jpg", ProductImage.find(@product_image.id).image.file.filename
  end

  test "should not update image with wrong extension" do
    invalid_params = { image: @not_image }
    assert_equal 1, ProductImage.count
    service = AdminServices::ProductImage::ChangeProductImage
              .new(id: @product_image.id, params: invalid_params, product_id: @product.id)
              .run
    refute service.success?
    assert_equal 1, service.result.errors.full_messages.count
    assert_equal "Image You are not allowed to upload \"txt\" files, allowed types: jpg, jpeg, gif, png", service.result.errors.full_messages.last
    assert_equal "tapir.jpg", ProductImage.find(@product_image.id).image.file.filename
  end
end
