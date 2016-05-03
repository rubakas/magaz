require 'test_helper'

class MagazCore::AdminServices::ProductImage::AddProductImageTest < ActiveSupport::TestCase

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
    assert_equal 0, MagazCore::ProductImage.count
    service = MagazCore::AdminServices::ProductImage::AddProductImage
                .run(image: @image, product_id: "#{@product.id}")
    assert service.valid?
    assert MagazCore::ProductImage.find(service.result.id)
    assert_equal 1, MagazCore::ProductImage.count
  end

  test "should not add image without image" do 
    assert_equal 0, MagazCore::ProductImage.count
    service = MagazCore::AdminServices::ProductImage::AddProductImage.run(image: nil, product_id: "#{@product.id}")
    refute service.valid?
    assert_equal 1, service.product_image.errors.full_messages.count
    assert_equal "Image is required", service.product_image.errors.full_messages.first
    assert_equal 0, MagazCore::ProductImage.count
  end

  test "should not create image with wrong extension" do
    assert_equal 0, MagazCore::ProductImage.count
    service = MagazCore::AdminServices::ProductImage::AddProductImage
                .run(product_id: "#{@product.id}", image: @not_image)
    refute service.valid?
    assert_equal 1, service.product_image.errors.full_messages.count
    assert_equal "Image You are not allowed to upload \"txt\" files, allowed types: jpg, jpeg, gif, png", service.product_image.errors.full_messages.last
    assert_equal 0, MagazCore::ProductImage.count
  end
end