require 'test_helper'

module MagazCore
  class ShopServices::AddBlogTest < ActiveSupport::TestCase

    setup do
      @shop = create(:shop, name: 'shop_name')
      @blog = create(:blog, shop: @shop)
      @success_params = { title: "Test title", shop_id: @shop.id, page_title: "Test page_title",
                          handle: "Test handle", meta_description: "Test meta_description" }
      @blank_params =   { title: "", shop_id: "", page_title: "",
                          handle: "", meta_description: "" }
    end

    test 'should create blog with valid params' do
      assert_equal 1, @shop.blogs.count
      service = MagazCore::ShopServices::AddBlog.run(@success_params)
      assert service.valid?
      assert MagazCore::Blog.find_by_id(service.result.id)
      assert_equal 'Test title', service.result.title
      assert_equal 2, @shop.blogs.count
    end

    test 'should not create blog with same params' do
      assert_equal 1, @shop.blogs.count
      service = MagazCore::ShopServices::AddBlog.run(@success_params)
      assert service.valid?

      service2 = MagazCore::ShopServices::AddBlog.run(@success_params)
      refute service2.valid?
      assert_equal 2, @shop.blogs.count
      assert_equal 1, service2.errors.full_messages.count
      assert_equal "Title has already been taken", service2.errors.full_messages.last
    end

    test 'should not create blog with blank params' do
      assert_equal 1, @shop.blogs.count
      service = MagazCore::ShopServices::AddBlog.run(@blank_params)
      refute service.valid?
      assert_equal 1, service.errors.full_messages.count
      assert_equal 1, @shop.blogs.count
    end
  end
end