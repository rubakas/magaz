require 'test_helper'

class BlogTest < ActiveSupport::TestCase
  should belong_to(:shop)
  
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
