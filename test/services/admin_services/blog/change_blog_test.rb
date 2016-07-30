require 'test_helper'

class AdminServices::Blog::ChangeBlogTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @blog = create(:blog, shop: @shop)
    @blog2 = create(:blog, shop: @shop, handle: "handle")
    @success_params = { title: "Changed title",
                        page_title: "Changed page_title", handle: "Changed handle",
                        meta_description: "Changed meta_description" }
    @blank_params =   { title: 'New Title', page_title: "",
                        handle: "", meta_description: "" }
  end

  test 'should update blog with valid params' do
    service = AdminServices::Blog::ChangeBlog
                .new(blog_id: @blog.id, shop_id: @shop.id, params: @success_params)
                .run
    assert service.success?
    assert_equal "Changed page_title", Blog.find(@blog.id).page_title
    assert_equal 'Changed title', Blog.find(@blog.id).title
    assert_equal "Changed handle", Blog.find(@blog.id).handle
  end

  test 'should not update blog with existing title' do
    invalid_params = @success_params.merge({title: @blog2.title})
    service = AdminServices::Blog::ChangeBlog
              .new(blog_id: @blog.id, shop_id: @shop.id, params: invalid_params)
              .run
    refute service.success?
    assert_equal 1, service.result.errors.full_messages.count
    assert_equal "Title has already been taken", service.result.errors.full_messages.first
  end

  test 'should update blog with some blank params' do
    service = AdminServices::Blog::ChangeBlog
                .new(blog_id: @blog.id, shop_id: @shop.id, params: @blank_params)
                .run
    assert service.success?
    assert_equal '', service.result.handle
    assert_equal '', service.result.page_title
  end

end
