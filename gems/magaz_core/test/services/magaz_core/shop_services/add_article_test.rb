require 'test_helper'

module MagazCore
  class ShopServices::AddArticleTest < ActiveSupport::TestCase

    setup do
      @shop = create(:shop, name: 'shop_name')
      @blog = create(:blog, shop: @shop)
      @success_params = { title: "Test title", blog_id: @blog.id, content: "Test text",
                          page_title: "Test page_title", handle: "Test handle", meta_description: "Test meta_description" }
      @blank_params =   { title: "", blog_id: "", content: "",
                          page_title: "", handle: "", meta_description: "" }
    end

    test 'should create article with valid params' do
      service = MagazCore::ShopServices::AddArticle.run(@success_params)
      assert service.valid?
      assert MagazCore::Article.find_by_id(service.result.id)
      assert_equal 'Test title', service.result.title
      assert_equal 1, @blog.articles.count
    end

    test 'should not create article with same params' do
      service = MagazCore::ShopServices::AddArticle.run(@success_params)
      assert service.valid?

      service2 = MagazCore::ShopServices::AddArticle.run(@success_params)
      refute service2.valid?
      assert_equal 1, @blog.articles.count
      assert_equal 1, service2.errors.full_messages.count
      assert_equal "Title has already been taken", service2.errors.full_messages.last
    end

    test 'should not create article with blank params' do
      service = MagazCore::ShopServices::AddArticle.run(@blank_params)
      refute service.valid?
      assert_equal 1, service.errors.full_messages.count
      assert_equal 0, @blog.articles.count
    end
  end
end