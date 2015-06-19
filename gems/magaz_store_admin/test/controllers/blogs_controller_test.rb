module MagazStoreAdmin
  require 'test_helper'

  class BlogsControllerTest < ActionController::TestCase
    setup do
      @shop = create(:shop, subdomain: 'example')
      @user = create(:user, shop: @shop)
      session_for_user @user
      @blog = create(:blog, shop: @shop, handle: "handle1")
    end

    test "should create event with blog" do
      assert_difference('MagazCore::Event.count', +1) do
        post :create, blog: { title: 'New uniq name' }
      end
    end

    test "should create event with update" do
      assert_difference('MagazCore::Event.count', +1) do
        patch :update, id: @blog.id, blog: { title: @blog.title }
      end
    end

    test "should create event with delete" do
      assert_difference('MagazCore::Event.count', +1) do
        delete :destroy, id: @blog.id
      end
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
        post :create, blog: { title: 'New uniq name' }
      end

      assert_redirected_to blog_path(assigns(:blog))
    end

    test "should show blog" do
      get :show, id: @blog.id
      assert_response :success
    end

    test "should update blog" do
      patch :update, id: @blog.id, blog: { title: @blog.title }
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

      assert_redirected_to blogs_path
    end
  end
end
