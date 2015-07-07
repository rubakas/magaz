# == Schema Information
#
# Table name: articles
#
#  id               :integer          not null, primary key
#  title            :string
#  content          :text
#  blog_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#  handle           :string
#  page_title       :string
#  meta_description :string
#  slug             :string
#  publish_on       :datetime
#  published_at     :datetime
#

require 'test_helper'

module MagazCore
  class ArticleTest < ActiveSupport::TestCase
    include MagazCore::Shared::VisibilityExamples

    should validate_presence_of(:title)
    should belong_to(:blog)
    should have_many(:events)
    should have_many(:comments)
    should validate_uniqueness_of(:title).scoped_to(:blog_id)

    setup do
      setup_visibility_examples(model_class: MagazCore::Article, factory_name: :article)
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
      @article2.save

      assert @article2.save
      refute @article1.slug == @article2.slug
    end
  end
end
