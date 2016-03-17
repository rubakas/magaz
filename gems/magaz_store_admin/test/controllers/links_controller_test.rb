module MagazStoreAdmin
  require 'test_helper'

  class LinksControllerTest < ActionController::TestCase

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
      get :new
      assert_response :success
    end

    test "should create link" do
      assert_difference('MagazCore::Link.count', +1) do
        post :create, { link: { name: "Test name", link_list_id: @link_list.id,
                                position: "position", link_type: "link_type" } }
      end

      assert_redirected_to link_path(assigns(:link))
    end

    test "should show link" do
      get :show,
        id: @link
      assert_response :success
    end

    test "should update link" do
      patch :update,
        { id: @link.id,
          link: { name: "Changed name", position: "Changed position", link_type: "Changed link_type"} }
      assert_response :redirect
    end

    test "should not update link" do
      patch :update, id: @link, link: { position: 'some position', name: '' }
      assert_response :success
    end

    test "should destroy link" do
      assert_difference('MagazCore::Link.count', -1) do
        delete :destroy, id: @link.id
      end

      assert_redirected_to link_list_path(@link_list)
    end
  end
end
