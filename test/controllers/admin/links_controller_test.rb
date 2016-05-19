require 'test_helper'

class Admin::LinksControllerTest < ActionController::TestCase

  setup do
    @shop = create(:shop, subdomain: 'example')
    @user = create(:user, shop: @shop)
    session_for_user @user
    @link_list = create(:link_list, shop: @shop)
    @link = create(:link, link_list: @link_list)
  end

  test "should get index" do
    get :index, link_list_id: @link_list.id
    assert_response :success
    assert_not_nil assigns(:links)
  end

  test "should get new" do
    get :new, link_list_id: @link_list.id
    assert_response :success
  end

  test "should create link" do
    assert_difference('Link.count', +1) do
      post :create, { link: { name: "Test name", position: "position", link_type: "link_type" },
                      link_list_id: @link_list.id }
    end

    assert_response :success
    assert_template 'show'
  end

  test "should show link" do
    get :show, link_list_id: @link_list.id,
      id: @link
    assert_response :success
  end

  test "should update link" do
    patch :update,
      { id: @link.id, link_list_id: @link_list.id,
        link: { name: "Changed name", position: "123", link_type: "Changed link_type"} }
    assert_response :redirect
  end

  test "should not update link" do
    patch :update, id: @link.id, link_list_id: @link_list.id,
                   link: { position: '123', name: '' }
    assert_template 'show'
    assert_response :success
  end

  test "should destroy link" do
    assert_difference('Link.count', -1) do
      delete :destroy, id: @link.id, link_list_id: @link_list.id
    end
    assert_redirected_to admin_link_list_path(@link_list)
  end

end
