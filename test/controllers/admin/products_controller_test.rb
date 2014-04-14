require 'test_helper'

class Admin::ProductsControllerTest < ActionController::TestCase
  setup do
    @shop = create(:shop, subdomain: 'example')
    session_for_shop @shop
    @product = create(:product, shop: @shop, handle: "handle1")
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
      post :create, { product: { name: 'Very Unique Name' } }
    end

    assert_redirected_to admin_product_path(assigns(:product))
  end

  test "should show product" do
    get :show,
      id: @product
    assert_response :success
  end

  test "should update product" do
    patch :update,
      { id: @product.id,
        product: { description: @product.description, name: @product.name } }
    assert_redirected_to admin_product_path(assigns(:product))
  end

  test "should not update product" do
    patch :update,
      { id: @product.id,
        product: { description: '', name: '' } }
    assert_template :show
    assert_response :success
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product.id
    end

    assert_redirected_to admin_products_path
  end
end