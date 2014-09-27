require 'test_helper'

class Admin::CustomersControllerTest < ActionController::TestCase
  setup do
    @shop = create(:shop, subdomain: 'example')
    session_for_shop @shop
    @customer = create(:customer, shop: @shop, first_name: "Some Uniq Name")
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customers)
  end

  test "returns a CSV file" do
    get :export, format: :csv
    assert_response :success
    assert_equal "text/csv", response.content_type
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('MagazCore::Customer.count') do
      post :create, { customer: { first_name: 'Very Unique Name' } }
    end

    assert_redirected_to admin_customer_path(assigns(:customer))
  end

  test "should show customer" do
    get :show,
      id: @customer
    assert_response :success
  end

  test "should update customer" do
    patch :update,
      { id: @customer.id,
        customer: { first_name: @customer.first_name } }
    assert_redirected_to admin_customer_path(assigns(:customer))
  end

  test "should destroy customer" do
    assert_difference('MagazCore::Customer.count', -1) do
      delete :destroy, id: @customer.id
    end
    assert_redirected_to admin_customers_path
  end

end
