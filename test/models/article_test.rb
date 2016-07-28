require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  
  should belong_to(:blog)
  should have_many(:comments)
  should have_many(:events)
  should validate_presence_of(:title)
  should validate_presence_of(:blog_id)
  should validate_uniqueness_of(:title).scoped_to(:blog_id)

  include Shared::VisibilityExamples

  setup do
    setup_visibility_examples(model_class: Article, factory_name: :article)
  end

  test 'two articles with same handle and different shops' do
    @shop1 = create(:shop, name: "shop1")
    @shop2 = create(:shop, name: "shop2")

    @blog1 = create(:blog, title: "blog", shop: @shop1)
    @blog2 = create(:blog, title: "blog", shop: @shop2)

    @article1 = create(:article, title: "article", handle: "article-handle", blog: @blog1)
    @article2 = @blog2.articles.new(title: "article", handle: "article-handle")

    assert @article2.save
    assert @article1.slug == @article2.slug
  end

  test 'two articles with same handle and same shop' do
    @shop1 = create(:shop, name: "shop1")
    @blog1 = create(:blog, title: "blog1")

    @article1 = create(:article, title: "article1", handle: "article-handle", blog: @blog1)

    @article2 = @blog1.articles.new(title: "article2", handle: "article-handle")

    refute @article2.save
  end
end
