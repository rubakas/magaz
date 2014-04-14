require 'test_helper'

class Admin::ProductImagesControllerTest < ActionController::TestCase
  setup do
    @shop = create(:shop, subdomain: 'example')
    session_for_shop @shop
    @product = create(:product, shop: @shop)
    @product_image = create(:product_image, product: @product)
  end

  test "should create product image" do
    assert_difference('ProductImage.count') do
      post :create, image: fixture_file_upload('/files/image.jpg')
    end

    assert_redirected_to admin_product_image_path(assigns(:product_image))
  end
end
