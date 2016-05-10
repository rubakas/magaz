require 'test_helper'

class Admin::BlogsControllerTest < ActionController::TestCase
  setup do
    @shop = create(:shop, subdomain: 'example')
    @user = create(:user, shop: @shop)
    session_for_user @user
    @blog = create(:blog, shop: @shop, handle: "handle1")
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:blogs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create blog" do
    assert_difference('MagazCore::Blog.count') do
      post :create, blog: { title: "Test title", shop_id: @shop.id, page_title: "Test page_title",
                            handle: "Test handle", meta_description: "Test meta_description" }
    end

    assert_redirected_to admin_blog_path(assigns(:blog))
  end

  test "should show blog" do
    get :show, id: @blog.id
    assert_response :success
  end

  test "should update blog" do
    patch :update, id: @blog.id, blog: { title: "Test title", shop_id: @shop.id, page_title: "Test page_title",
                                         handle: "Test handle", meta_description: "Test meta_description" }
    assert_response :redirect
  end

  test "should not update blog" do
    patch :update, id: @blog.id, blog: { title: '' }
    assert_response :success
  end

  test "should destroy blog" do
    assert_difference('MagazCore::Blog.count', -1) do
      delete :destroy, id: @blog.id
    end

    assert_redirected_to admin_blogs_path
  end
end
