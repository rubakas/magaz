require 'test_helper'
class AdminServices::ProductImage::DeleteProductImageTest < ActiveSupport::TestCase

 setup do
    @shop = create(:shop, name: "shop name")
    @product = create(:product, shop: @shop)
    @image = fixture_file_upload('/files/tapir.jpg', 'image/jpg')
    @product_image = create(:product_image, product: @product, image: @image)
  end

  test "should delete image with valid params" do
    assert_equal 1, ProductImage.count
    service = AdminServices::ProductImage::DeleteProductImage
              .new(id: @product_image.id, product_id: @product.id)
              .run
    assert service.success?
    assert_equal 0, ProductImage.count
  end

end
