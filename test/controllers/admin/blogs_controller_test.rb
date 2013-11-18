require 'test_helper'

class Admin::BlogsControllerTest < ActionController::TestCase
  setup do
    session_for_shop shops(:shop_1)
    @blog = blogs(:one)
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
    assert_difference('Blog.count') do
      post :create, blog: { title: 'New uniq name' }
    end

    assert_redirected_to admin_blog_path(assigns(:blog))
  end

  test "should show blog" do
    get :show, id: @blog
    assert_response :success
  end

  test "should update blog" do
    patch :update, id: @blog, blog: { title: @blog.title }
    assert_response :success
  end

  test "should destroy blog" do
    assert_difference('Blog.count', -1) do
      delete :destroy, id: @blog
    end

    assert_redirected_to admin_blogs_path
  end
end
