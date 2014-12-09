require 'test_helper'

class Admin::ProductImagesControllerTest < ActionController::TestCase
  
  setup do
    @shop = create(:shop, subdomain: 'example')
    session_for_shop @shop
    @product = create(:product, shop: @shop, handle: "handle1")
    @product_image = create(:product_image, product: @product)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_images)
  end

  test 'should show image' do
    get :show, id: @product_image
    assert_response :success
  end

  test 'should get new' do
    get :new
    assert_response :success
  end


  test 'should destroy image' do
    assert_difference('MagazCore::ProductImage.count', -1) do
      delete :destroy, id: @product_image.id
    end
    assert_redirected_to admin_product_images_path
  end

end
