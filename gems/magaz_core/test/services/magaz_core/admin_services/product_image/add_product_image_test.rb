require 'test_helper'

class MagazCore::AdminServices::ProductImage::AddProductImageTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: "shop name")
    @product = create(:product, shop: @shop)
    @image = fixture_file_upload('/files/tapir.jpg', 'image/jpg')
  end

  teardown do
    FileUtils.rm_rf(Dir["#{Rails.root}/uploads"])
  end

  test "should add image with valid params" do 
    assert_equal 0, MagazCore::ProductImage.count
    service = MagazCore::AdminServices::ProductImage::AddProductImage
                .run(image: @image, product_id: @product.id)
    assert service.valid?
    assert MagazCore::ProductImage.find(service.result.id)
    assert_equal 1, MagazCore::ProductImage.count
  end

  test "should not add image with blank params" do 
    assert_equal 0, MagazCore::ProductImage.count
    service = MagazCore::AdminServices::ProductImage::AddProductImage.run(image: "", product_id: "")
    refute service.valid?
    assert_equal 2, service.errors.full_messages.count
    assert_equal 0, MagazCore::ProductImage.count
  end
end