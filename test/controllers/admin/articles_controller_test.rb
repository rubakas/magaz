require 'test_helper'

class Admin::ArticlesControllerTest < ActionController::TestCase
  setup do
    @shop = create(:shop, subdomain: 'example')
    @blog = create(:blog, shop: @shop, handle: "handle1")
    session_for_shop @shop
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
    assert_difference('MagazCore::Article.count') do
      post :create, { article: { content: @article.content, title: 'New uniq name' } }
    end

    assert_redirected_to admin_article_path(assigns(:article))
  end

  test "should show article" do
    get :show,
      id: @article
    assert_response :success
  end

  test "should update article" do
    patch :update,
      { id: @article.id,
        article: { content: @article.content, title: @article.title } }
    assert_response :redirect
  end

  test "should not update article" do
    patch :update, id: @article, article: { content: @article.content, title: '' }
    assert_response :success
  end

  test "should destroy article" do
    assert_difference('MagazCore::Article.count', -1) do
      delete :destroy, id: @article.id
    end

    assert_redirected_to admin_articles_path
  end
end
