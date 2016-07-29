require 'test_helper'

class AdminServices::Article::AddArticleTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @blog = create(:blog, shop: @shop)
    @success_params = { title: "Test title", blog_id: @blog.id, content: "Test text",
                        page_title: "Test page_title", handle: "Test handle", meta_description: "Test meta_description" }
    @blank_params =   { title: "", blog_id: "", content: "",
                        page_title: "", handle: "", meta_description: "" }
  end

  test 'should create article with valid params' do
    service = AdminServices::Article::AddArticle
              .new(blog_id: @blog.id, params: @success_params)
              .run()
    assert service.success?
    assert Article.find_by_id(service.result.id)
    assert_equal 'Test title', service.result.title
    assert_equal 1, @blog.articles.count
  end

  test 'should not create article with same params' do
    service = AdminServices::Article::AddArticle
              .new(blog_id: @blog.id, params: @success_params)
              .run()
    assert service.success?
    service2 = AdminServices::Article::AddArticle
                .new(blog_id: @blog.id, params: @success_params)
                .run()
    refute service2.success?
    assert_equal 1, @blog.articles.count
    assert_equal "Title has already been taken", service2.result.errors.full_messages.first
  end

  test 'should not create article with blank params' do
    service = AdminServices::Article::AddArticle
              .new(blog_id: @blog.id, params: @blank_params)
              .run()
    refute service.success?
    assert_equal 1, service.result.errors.full_messages.count
    assert_equal 0, @blog.articles.count
  end

end
