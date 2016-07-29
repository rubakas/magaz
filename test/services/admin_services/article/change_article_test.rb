require 'test_helper'

class AdminServices::Article::ChangeArticleTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @blog = create(:blog, shop: @shop)
    @second_blog = create(:blog, shop: @shop)
    @another_article = create(:article, blog: @second_blog, handle: "myhandle", title: "mytitle")
    @article = create(:article, blog: @blog)
    @article2 = create(:article, blog: @blog, handle: "Unique handle")
    @success_params = { id: @article.id.to_s, title: "Changed title", blog_id: @blog.id,
                        content: "Changed content", page_title: "Changed page_title", handle: "ChangedC handle",
                        meta_description: "Changed meta_description" }
    @blank_params =   { id: @article2.id.to_s, title: "", blog_id: "",
                        page_title: "", handle: "", content: "",
                        meta_description: "" }
  end

  test 'should update article with valid params' do
    service = AdminServices::Article::ChangeArticle
              .new(blog_id: @blog.id, article_id: @article.id, params: @success_params)
              .run()
    assert service.success?
    assert_equal "Changed content", Article.find(@article.id).content
    assert_equal 'Changed title', Article.find(@article.id).title
  end

  test 'should not update article with blank_params' do
    service = AdminServices::Article::ChangeArticle
              .new(blog_id: @blog.id, article_id: @article.id, params: @blank_params)
              .run()
    refute service.success?
  end

  test 'should not update article with existing title' do
    invalid_params = @success_params.merge({title: @article2.title})
    service = AdminServices::Article::ChangeArticle
              .new(blog_id: @blog.id, article_id: @article.id, params: invalid_params)
              .run
    refute service.success?
    assert_equal 1, service.result.errors.full_messages.count
    assert_equal "Title has already been taken", service.result.errors.full_messages.first
  end

  test 'should not update article with existing handle' do
    invalid_params = @success_params.merge({handle: @article2.handle})
    service = AdminServices::Article::ChangeArticle
              .new(blog_id: @blog.id, article_id: @article.id, params: invalid_params)
              .run
    refute service.success?
    assert_equal 1, service.result.errors.full_messages.count
    assert_equal "Handle has already been taken", service.result.errors.full_messages.first
  end

  test 'should not update article with existing handle when blog is changed' do
    invalid_params = @success_params.merge({handle: @another_article.handle})
    service = AdminServices::Article::ChangeArticle
              .new(blog_id: @second_blog.id, article_id: @article.id, params: invalid_params)
              .run
    refute service.success?
    assert_equal 1, service.result.errors.full_messages.count
    assert_equal "Handle has already been taken", service.result.errors.full_messages.first
  end

  test 'should not update article with existing title when blog is changed' do
    invalid_params = @success_params.merge({title: @another_article.title})
    service = AdminServices::Article::ChangeArticle
              .new(blog_id: @second_blog.id, article_id: @article.id, params: invalid_params)
              .run
    refute service.success?
    assert_equal 1, service.result.errors.full_messages.count
    assert_equal "Title has already been taken", service.result.errors.full_messages.first
  end

  test 'should update article with some blank params' do
    blank_params = { title: @article.title, content:  "", page_title: "", handle:   "", meta_description: ""}

    service = AdminServices::Article::ChangeArticle
              .new(blog_id: @blog.id, article_id: @article.id, params: blank_params)
              .run
    assert service.success?
    assert_equal '', service.result.handle
    assert_equal '', service.result.page_title
  end

end
