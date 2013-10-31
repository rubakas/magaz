require 'test_helper'

class Admin::ProductsControllerTest < ActionController::TestCase
  setup do
    session_for_shop shops(:shop_1)
    @product = products(:product_1)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: { description: 'Some desc', name: 'Very Unique Name', product_type: 'Sample Type' }
    end

    assert_redirected_to admin_product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should update product" do
    patch :update, id: @product, product: { description: @product.description, name: @product.name }
    assert_redirected_to admin_product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end

    assert_redirected_to admin_products_path
  end
end
