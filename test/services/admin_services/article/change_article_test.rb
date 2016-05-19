require 'test_helper'

class AdminServices::Article::ChangeArticleTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @blog = create(:blog, shop: @shop)
    @second_blog = create(:blog, shop: @shop)
    @another_article = create(:article, blog: @second_blog, handle: "myhandle", title: "mytitle")
    @article = create(:article, blog: @blogm)
    @article2 = create(:article, blog: @blog, handle: "Unique handle")
    @success_params = { id: @article.id.to_s, title: "Changed title", blog_id: @blog.id,
                        content: "Changed content", page_title: "Changed page_title", handle: "ChangedC handle",
                        meta_description: "Changed meta_description" }
    @blank_params =   { id: @article2.id.to_s, title: "", blog_id: "",
                        page_title: "", handle: "", content: "",
                        meta_description: "" }
  end

  test 'should update article with valid params' do
    service = AdminServices::Article::ChangeArticle.run(@success_params)
    assert service.valid?
    assert_equal "Changed content", Article.find(@article.id).content
    assert_equal 'Changed title', Article.find(@article.id).title
  end

  test 'should not update article with blank_params' do
    service = AdminServices::Article::ChangeArticle.run(@blank_params)
    refute service.valid?
    assert_equal 1, service.article.errors.full_messages.count
    assert_equal "Blog is not a valid integer", service.article.errors.full_messages.first
  end

  test 'should not update article with existing title' do
    service = AdminServices::Article::ChangeArticle.
                run(id: @article.id.to_s, title: @article2.title, blog_id: @blog.id,
                    content: "Changed content", page_title: "Changed page_title", handle: "ChangedC handle",
                    meta_description: "Changed meta_description")
    refute service.valid?
    assert_equal 1, service.errors.full_messages.count
    assert_equal "Title has already been taken", service.errors.full_messages.first
  end

  test 'should not update article with existing handle' do
    service = AdminServices::Article::ChangeArticle.
                run(id: @article.id.to_s, title: "New title", blog_id: @blog.id,
                    content: "Changed content", page_title: "Changed page_title", handle: @article2.handle,
                    meta_description: "Changed meta_description")
    refute service.valid?
    assert_equal 1, service.article.errors.full_messages.count
    assert_equal "Handle has already been taken", service.article.errors.full_messages.first
  end

  test 'should not update article with existing handle when blog is changed' do
    service = AdminServices::Article::ChangeArticle.
                run(id: @article.id.to_s, title: "New title", blog_id: @second_blog.id,
                    content: "Changed content", page_title: "Changed page_title", handle: @another_article.handle,
                    meta_description: "Changed meta_description")
    refute service.valid?
    assert_equal 1, service.article.errors.full_messages.count
    assert_equal "Handle has already been taken", service.article.errors.full_messages.first
  end

  test 'should not update article with existing title when blog is changed' do
    service = AdminServices::Article::ChangeArticle.
                run(id: @article.id.to_s, title: @another_article.title, blog_id: @second_blog.id,
                    content: "Changed content", page_title: "Changed page_title", handle: "handle",
                    meta_description: "Changed meta_description")
    refute service.valid?
    assert_equal 1, service.article.errors.full_messages.count
    assert_equal "Title has already been taken", service.article.errors.full_messages.first
  end

  test 'should update article with some blank params' do
    service = AdminServices::Article::ChangeArticle.
                run(id: @article2.id.to_s, title: @article2.title, blog_id: @blog.id,
                    content: "", page_title: "", handle: "",
                    meta_description: "")
    assert service.valid?
    assert_equal '', service.result.handle
    assert_equal '', service.result.page_title
  end

end
