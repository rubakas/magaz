require 'test_helper'

module MagazCore
  class ShopServices::DeleteBlogTest < ActiveSupport::TestCase

    setup do
      @shop = create(:shop, name: 'shop_name')
      @blog = create(:blog, shop: @shop)
      @blog2 = create(:blog, shop: @shop)
    end

    test 'should delete blog with valid id' do
      assert_equal 2, @shop.blogs.count
      service = MagazCore::ShopServices::DeleteBlog.run(id: @blog.id)
      assert service.valid?
      refute MagazCore::Blog.find_by_id(@blog.id)
      assert MagazCore::Blog.find_by_id(@blog2.id)
      assert_equal 1, @shop.blogs.count
    end

    test 'should not delete blog with valid blank id' do
      assert_equal 2, @shop.blogs.count
      service = MagazCore::ShopServices::DeleteBlog.run(id: "")
      refute service.valid?
      assert_equal 2, @shop.blogs.count
    end
  end
end