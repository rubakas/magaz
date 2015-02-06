require 'test_helper'

class Admin::ProductImagesControllerTest < ActionController::TestCase

  setup do
    @shop = create(:shop, subdomain: 'example')
    @user = create(:user, shop: @shop)
    session_for_user @user
    @product = create(:product, shop: @shop, handle: "handle1")
    @product_image = create(:product_image, product: @product)
  end

  test 'should get index' do
    get :index, product_id: @product ,id: @product_image
    assert_response :success
    assert_not_nil assigns(:product_images)
  end

  test 'should show image' do
    get :show, product_id: @product ,id: @product_image
    assert_response :success
  end

  test 'should get new' do
    get :new, product_id: @product ,id: @product_image
    assert_response :success
  end

  test 'should update image' do
    patch :update, product_id: @product ,id: @product_image
     { product_image: {image: 'sell_bg_berlin.jpg' }}
      assert_template :show
      assert_response :success
  end

  test 'should not update image' do
    patch :update, product_id: @product ,id: @product_image
     { product_image: {image: ''}}
      assert_template :show
      assert_response :success
  end

  test 'should create image' do
    assert_difference('MagazCore::ProductImage.count') do
      post :create, product_id: @product , id: @product_image
      {product_image: {image: 'sell_bg_berlin.jpg'}}
    end
  end


  test 'should destroy image' do
    assert_difference('MagazCore::ProductImage.count', -1) do
      delete :destroy, product_id: @product , id: @product_image
    end
    assert_redirected_to admin_product_product_images_path
  end
end
