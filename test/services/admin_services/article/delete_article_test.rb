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
    service = AdminServices::Article::DeleteArticle.run(id: @article.id.to_s)
    assert service.valid?
    refute Article.find_by_id(@article.id)
    assert Article.find_by_id(@article2.id)
    assert_equal 1, @blog.articles.count
  end

  test 'should not delete article with valid blank id' do
    assert_equal 2, @blog.articles.count
    service = AdminServices::Article::DeleteArticle.run(id: "")
    refute service.valid?
    assert_equal 1, service.errors.count
    assert_equal "Id can't be blank", service.errors.full_messages.last
    assert_equal 2, @blog.articles.count
  end
end
