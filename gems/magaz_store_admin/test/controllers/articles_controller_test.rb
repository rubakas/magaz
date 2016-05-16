require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase

  setup do
    @shop = create(:shop, subdomain: 'example')
    @user = create(:user, shop: @shop)
    session_for_user @user
    @blog = create(:blog, shop: @shop, handle: "handle1")
    @article = create(:article, blog: @blog, handle: "handle1")
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:articles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create article" do
    assert_difference('MagazCore::Article.count', +1) do
      post :create, { article: { title: "Changed title", blog_id: @blog.id,
                                 content: "Changed content", page_title: "Changed page_title",
                                 handle: "Changed handle", meta_description: "Changed meta_description" } }
    end

    assert_redirected_to article_path(assigns(:article))
  end

  test "should show article" do
    get :show,
      id: @article
    assert_response :success
  end

  test "should update article" do
    patch :update,
      { id: @article.id,
        article: { title: "Changed title", blog_id: @blog.id,
                   content: "Changed content", page_title: "Changed page_title",
                   handle: "ChangedC handle", meta_description: "Changed meta_description"} }
    assert_response :redirect
  end

  test "should not update article" do
    patch :update, id: @article, article: { content: @article.content, title: '', blog_id: @blog.id }
    assert_response :success
  end

  test "should destroy article" do
    assert_difference('MagazCore::Article.count', -1) do
      delete :destroy, id: @article.id.to_s
    end

    assert_redirected_to articles_path
  end
end
