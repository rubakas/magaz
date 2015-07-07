# == Schema Information
#
# Table name: blogs
#
#  id               :integer          not null, primary key
#  title            :string
#  shop_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#  handle           :string
#  page_title       :string
#  meta_description :string
#  slug             :string
#

require 'test_helper'

module MagazCore
  class BlogTest < ActiveSupport::TestCase

    should have_many(:articles)
    should have_many(:comments)
    should have_many(:events)
    should belong_to(:shop)
    should validate_presence_of(:title)
    should validate_uniqueness_of(:title).scoped_to(:shop_id)

    test 'two blogs with same handle and different shops' do
      @shop1 = create(:shop, name: "shop1")
      @shop2 = create(:shop, name: "shop2")
      @blog1 = create(:blog, title: "blog", handle: "blog-handle", shop: @shop1)

      @blog2 = @shop2.blogs.new(title: "blog", handle: "blog-handle")

      assert @blog2.save
      assert @blog1.slug == @blog2.slug
    end

    test 'two blogs with same handle and same shop' do
      @shop1 = create(:shop, name: "shop1")

      @blog1 = create(:blog, title: "blog1", handle: "blog-handle", shop: @shop1)

      @blog2 = @shop1.blogs.new(title: "blog2", handle: "blog-handle")
      @blog2.save

      assert @blog2.save
      refute @blog1.slug == @blog2.slug
    end
  end
end
