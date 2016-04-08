require 'test_helper'
class MagazCore::AdminServices::ProductImage::ChangeProductImageTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: "shop name")
    @product = create(:product, shop: @shop)
    @image = fixture_file_upload('/files/tapir.jpg', 'image/jpg')
    @image2 = fixture_file_upload('/files/sell_bg_berlin.jpg', 'image/jpg')
    @not_image = fixture_file_upload('/files/test.txt', 'image/jpg')
    @product_image = create(:product_image, product: @product, image: @image)
  end

  teardown do
    FileUtils.rm_rf(Dir["#{Rails.root}/uploads"])
  end

  test "should update image with valid params" do
    assert_equal 1, MagazCore::ProductImage.count
    service = MagazCore::AdminServices::ProductImage::ChangeProductImage
                .run(id: @product_image.id, image: @image2)
    assert service.valid?
    assert_equal "sell_bg_berlin.jpg", MagazCore::ProductImage.find(@product_image.id)
                                         .image.file.filename
  end

  test "should not update image with blank params" do
    assert_equal 1, MagazCore::ProductImage.count
    service = MagazCore::AdminServices::ProductImage::ChangeProductImage
                .run(id: "", image: "")
    refute service.valid?
    assert_equal 2, service.errors.full_messages.count
    assert_equal "Id is not a valid integer", service.errors.full_messages.last
    assert_equal "Image is not a valid file", service.errors.full_messages.first
    assert_equal "tapir.jpg", MagazCore::ProductImage.find(@product_image.id).image.file.filename
  end

  test "should not update image with wrong extension" do
    assert_equal 1, MagazCore::ProductImage.count
    service = MagazCore::AdminServices::ProductImage::ChangeProductImage
                .run(id: @product_image.id, image: @not_image)
    refute service.valid?
    assert_equal 1, service.errors.full_messages.count
    assert_equal "Image You are not allowed to upload \"txt\" files, allowed types: jpg, jpeg, gif, png", service.errors.full_messages.last
    assert_equal "tapir.jpg", MagazCore::ProductImage.find(@product_image.id).image.file.filename

  end
end