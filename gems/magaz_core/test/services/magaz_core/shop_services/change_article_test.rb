require 'test_helper'

module MagazCore
  class ShopServices::ChangeArticleTest < ActiveSupport::TestCase

    setup do
      @shop = create(:shop, subdomain: 'shop_name')
      @blog = create(:blog, shop: @shop)
      @article = create(:article, blog: @blog)
      @article2 = create(:article, blog: @blog)
      @success_params = { article: @article, title: "Changed title", blog_id: @blog.id,
                          content: "Changed content", page_title: "Changed page_title", handle: "ChangedC handle",
                          meta_description: "Changed meta_description" }
    end

    test 'should update article with valid params' do
      service = MagazCore::ShopServices::ChangeArticle.run(@success_params)
      assert service.valid?
      assert_equal "Changed content", MagazCore::Article.find(@article.id).content
      assert_equal 'Changed title', MagazCore::Article.find(@article.id).title
    end

    test 'should not update article with existing title' do
      service = MagazCore::ShopServices::ChangeArticle.
                  run(article: @article, title: @article2.title, blog_id: @blog.id,
                      content: "Changed content", page_title: "Changed page_title", handle: "ChangedC handle",
                      meta_description: "Changed meta_description")
      refute service.valid?
      assert_equal 1, service.errors.full_messages.count
      assert_equal "Title has already been taken", service.errors.full_messages.first
    end

    test 'should update article with some blank params' do
      service = MagazCore::ShopServices::ChangeArticle.
                  run(article: @article, title: @article.title, blog_id: @blog.id,
                      content: "", page_title: "", handle: "",
                      meta_description: "")
      assert service.valid?
      assert_equal '', service.result.handle
      assert_equal '', service.result.page_title
    end
  end
end