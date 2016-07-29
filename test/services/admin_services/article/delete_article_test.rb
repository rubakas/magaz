require 'test_helper'

class AdminServices::DeleteArticleTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @blog = create(:blog, shop: @shop)
    @article = create(:article, blog: @blog)
    @article2 = create(:article, blog: @blog)
  end

  test 'should delete article with valid id' do
    assert_equal 2, @blog.articles.count
    service = AdminServices::Article::DeleteArticle.new(id: @article.id.to_s).run
    assert service.success?
    refute Article.find_by_id(@article.id)
    assert Article.find_by_id(@article2.id)
    assert_equal 1, @blog.articles.count
  end

  test 'should not delete article with valid blank id' do
    assert_equal 2, @blog.articles.count
    assert_raises ActiveRecord::RecordNotFound do
      service = AdminServices::Article::DeleteArticle.new(id: "").run
    end
  end
end
