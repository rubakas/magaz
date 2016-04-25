require 'test_helper'
class MagazCore::AdminServices::ProductImage::DeleteProductImageTest < ActiveSupport::TestCase

 setup do
    @shop = create(:shop, name: "shop name")
    @product = create(:product, shop: @shop)
    @image = fixture_file_upload('/files/tapir.jpg', 'image/jpg')
    @product_image = create(:product_image, product: @product, image: @image)
  end

  teardown do
    FileUtils.rm_rf(Dir["#{Rails.root}/uploads"])
  end

  test "should delete image with valid params" do
    assert_equal 1, MagazCore::ProductImage.count
    service = MagazCore::AdminServices::ProductImage::DeleteProductImage
                .run(id: @product_image.id, product_id: @product_image.id)
    assert service.valid?
    assert_equal 0, MagazCore::ProductImage.count
  end

  test "should not delete image with blank params" do
    assert_equal 1, MagazCore::ProductImage.count
    service = MagazCore::AdminServices::ProductImage::DeleteProductImage
                .run(id: "", product_id: '')
    refute service.valid?
    assert_equal 2, service.errors.full_messages.count
    assert_equal "Id is not a valid integer", service.errors.full_messages.first
    assert_equal 1, MagazCore::ProductImage.count
  end
end