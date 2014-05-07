require 'test_helper'

class Admin::CollectionsControllerTest < ActionController::TestCase
  setup do
    @shop = create(:shop, subdomain: 'example')
    session_for_shop @shop
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

    assert_redirected_to admin_collection_path(assigns(:collection))
  end

  test "should show collection" do
    get :show, id: @collection
    assert_response :success
  end

  test "should update collection" do
    patch :update, id: @collection, collection: { description: @collection.description, name: @collection.name }
    assert_redirected_to admin_collection_path(assigns(:collection))
  end

  test "should destroy collection" do
    assert_difference('MagazCore::Collection.count', -1) do
      delete :destroy, id: @collection
    end

    assert_redirected_to admin_collections_path
  end
end
