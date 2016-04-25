module MagazStoreAdmin
  require 'test_helper'

  class CustomersControllerTest < ActionController::TestCase
    setup do
      @shop = create(:shop, subdomain: 'example')
      @user = create(:user, shop: @shop)
      session_for_user @user
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

    test "should create customer" do
      assert_difference('MagazCore::Customer.count') do
        post :create, { customer: { email: 'email@gmail.com', first_name: "Some First Name", last_name: "Some Last Name" } }
      end

      assert_redirected_to customer_path(assigns(:customer))
    end

    test "should show customer" do
      get :show,
        id: @customer
      assert_response :success
    end

    test "should update customer" do
      patch :update,
        { id: @customer.id,
          customer: { first_name: @customer.first_name, last_name: "Changed Last Name", email: "changed@gamil.com" } }
      assert_redirected_to customer_path(assigns(:customer))
    end

    test "should destroy customer" do
      assert_difference('MagazCore::Customer.count', -1) do
        delete :destroy, id: @customer.id, shop_id: @shop.id
      end
      assert_redirected_to customers_path
    end

  end
end
