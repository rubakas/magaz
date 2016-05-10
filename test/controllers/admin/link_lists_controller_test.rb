require 'test_helper'

class LinkListsControllerTest < ActionController::TestCase

  setup do
    @shop = create(:shop, subdomain: 'example')
    @user = create(:user, shop: @shop)
    session_for_user @user
    @link_list = create(:link_list, shop: @shop, handle: "handle1")
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:link_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create link_list" do
    assert_difference('MagazCore::LinkList.count', +1) do
      post :create, { link_list: { name: "title", handle: "handle", shop_id: @shop.id} }
    end

    assert_redirected_to link_list_path(assigns(:link_list))
  end

  test "should show link_list" do
    get :show,
      id: @link_list
    assert_response :success
  end

  test "should update link_list" do
    patch :update,
      { id: @link_list.id,
        link_list: { name: "Changed title", handle: "Changed handle"} }
    assert_response :redirect
  end

  test "should not update link_list" do
    patch :update, id: @link_list, link_list: { handle: @link_list.handle }
    assert_response :success
  end

  test "should destroy link_list" do
    assert_difference('MagazCore::LinkList.count', -1) do
      delete :destroy, id: "#{@link_list.id}", shop_id: @shop.id
    end

    assert_redirected_to link_lists_path
  end
end
