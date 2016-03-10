require 'test_helper'

module MagazCore
  class ShopServices::DeleteArticleTest < ActiveSupport::TestCase

    setup do
      @blog = create(:blog, shop: @shop)
      @article = create(:article, blog: @blog)
      @article2 = create(:article, blog: @blog)
    end

    test 'should delete article with valid id' do
      assert_equal 2, @blog.articles.count
      service = MagazCore::ShopServices::DeleteArticle.run(id: @article.id)
      assert service.valid?
      refute MagazCore::Article.find_by_id(@article.id)
      assert MagazCore::Article.find_by_id(@article2.id)
      assert_equal 1, @blog.articles.count
    end

    test 'should not delete article with valid blank id' do
      assert_equal 2, @blog.articles.count
      service = MagazCore::ShopServices::DeleteArticle.run(id: "")
      refute service.valid?
      assert_equal 2, @blog.articles.count
    end
  end
end