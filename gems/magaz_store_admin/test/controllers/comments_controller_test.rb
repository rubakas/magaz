module MagazStoreAdmin
  require 'test_helper'

  class CommentsControllerTest < ActionController::TestCase
    setup do
      @shop = create(:shop, subdomain: 'example')
      @blog = create(:blog, shop: @shop)
      @article = create(:article, blog: @blog)
      @user = create(:user, shop: @shop)
      session_for_user @user
      @comment = create(:comment, article: @article)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:comments)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create comment" do
      assert_difference('MagazCore::Comment.count') do
        post :create, comment: { author: 'New uniq name', email: @comment.email,
                                 body: @comment.body, blog_id: @blog.id, article_id: @article.id}
      end

      assert_redirected_to comment_path(assigns(:comment))
    end

    test "should show comment" do
      get :show, id: @comment.id
      assert_response :success
    end

    test "should update comment" do
      patch :update, id: @comment.id, comment: { author: @comment.author, email: @comment.email, body: @comment.body }
      assert_response :redirect
    end

    test "should not update comment" do
      patch :update, id: @comment.id, comment: { author: '', email: '', body: '' }
      assert_response :success
    end

    test "should destroy comment" do
      assert_difference('MagazCore::Comment.count', -1) do
        delete :destroy, id: @comment.id
      end

      assert_redirected_to comments_path
    end
  end
end
