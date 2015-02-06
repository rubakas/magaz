require 'test_helper'

class Admin::PagesControllerTest < ActionController::TestCase
  setup do
    @shop = create(:shop, subdomain: 'example')
    @user = create(:user, shop: @shop)
    session_for_user @user
    @page = create(:page, shop: @shop, handle: "handle1")
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create page" do
    assert_difference('MagazCore::Page.count') do
      post :create, page: { content: @page.content, title: 'New uniq name' }
    end

    assert_redirected_to admin_page_path(assigns(:page))
  end

  test "should show page" do
    get :show, id: @page
    assert_response :success
  end

  test "should update page" do
    patch :update, id: @page, page: { content: @page.content, title: @page.title }
    assert_response :redirect
  end

  test "should not update page" do
    patch :update, id: @page, page: { content: @page.content, title: '' }
    assert_template :show
    assert_response :success
  end

  test "should destroy page" do
    assert_difference('MagazCore::Page.count', -1) do
      delete :destroy, id: @page
    end

    assert_redirected_to admin_pages_path
  end
end
