module MagazStoreAdmin
  require 'test_helper'

  class CollectionsControllerTest < ActionController::TestCase
    setup do
      @shop = create(:shop, subdomain: 'example')
      @user = create(:user, shop: @shop)
      session_for_user @user
      @collection = create(:collection, shop: @shop, handle: "handle1")
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:collections)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create product" do
      assert_difference('MagazCore::Collection.count') do
        post :create, collection: { name: 'Unique Name' }
      end

      assert_redirected_to collection_path(assigns(:collection))
    end

    test "should show collection" do
      get :show, id: @collection
      assert_response :success
    end

    test "should update collection" do
      patch :update, id: @collection, collection: { description: @collection.description, name: @collection.name }
      assert_redirected_to collection_path(assigns(:collection))
    end

    test "should destroy collection" do
      assert_difference('MagazCore::Collection.count', -1) do
        delete :destroy, id: @collection
      end

      assert_redirected_to collections_path
    end
  end
end
