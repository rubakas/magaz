require 'test_helper'

class AdminServices::ProductImage::AddProductImageTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: "shop name")
    @product = create(:product, shop: @shop)
    @image = fixture_file_upload('/files/tapir.jpg', 'image/jpg')
    @not_image = fixture_file_upload('/files/test.txt', 'image/jpg')
  end

  teardown do
    FileUtils.rm_rf(Dir["#{Rails.root}/uploads"])
  end

  test "should add image with valid params" do
    assert_equal 0, ProductImage.count
    service = AdminServices::ProductImage::AddProductImage
                .run(image: @image, product_id: "#{@product.id}")
    assert service.valid?
    assert ProductImage.find(service.result.id)
    assert_equal 1, ProductImage.count
  end

  test "should not add image without image" do
    assert_equal 0, ProductImage.count
    service = AdminServices::ProductImage::AddProductImage.run(image: nil, product_id: "#{@product.id}")
    refute service.valid?
    assert_equal 1, service.product_image.errors.full_messages.count
    assert_equal "Image is required", service.product_image.errors.full_messages.first
    assert_equal 0, ProductImage.count
  end

  test "should not create image with wrong extension" do
    assert_equal 0, ProductImage.count
    service = AdminServices::ProductImage::AddProductImage
                .run(product_id: "#{@product.id}", image: @not_image)
    refute service.valid?
    assert_equal 1, service.product_image.errors.full_messages.count
    assert_equal "Image You are not allowed to upload \"txt\" files, allowed types: jpg, jpeg, gif, png", service.product_image.errors.full_messages.last
    assert_equal 0, ProductImage.count
  end
end
