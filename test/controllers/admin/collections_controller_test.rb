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

  test "should create collection" do
    assert_difference('MagazCore::Collection.count') do
      post :create, collection: { name: "Test name", shop_id: @shop.id, page_title: "Test page_title",
                                  handle: "Test handle", meta_description: "Test meta_description", description: "Test description" }
    end

    assert_redirected_to collection_path(assigns(:collection))
  end

  test "should show collection" do
    get :show, id: @collection
    assert_response :success
  end

  test "should update collection" do
    patch :update, id: @collection, collection: { name: "Changed name", shop_id: @shop.id, page_title: "Changed page_title",
                                                  handle: "Changed handle", meta_description: "Changed meta_description", description: "Changed description" }
    assert_redirected_to collection_path(assigns(:collection))
  end

  test "should destroy collection" do
    assert_difference('MagazCore::Collection.count', -1) do
      delete :destroy, id: @collection.id.to_s, shop_id: @shop.id
    end

    assert_redirected_to collections_path
  end
end
