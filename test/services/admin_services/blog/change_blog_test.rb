require 'test_helper'

class AdminServices::Blog::ChangeBlogTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @blog = create(:blog, shop: @shop)
    @blog2 = create(:blog, shop: @shop, handle: "handle")
    @success_params = { id: @blog.id.to_s, title: "Changed title", shop_id: @shop.id,
                        page_title: "Changed page_title", handle: "Changed handle",
                        meta_description: "Changed meta_description" }
  end

  test 'should update blog with valid params' do
    service = AdminServices::Blog::ChangeBlog.run(@success_params)
    assert service.valid?
    assert_equal "Changed page_title", Blog.find(@blog.id).page_title
    assert_equal 'Changed title', Blog.find(@blog.id).title
    assert_equal "Changed handle", Blog.find(@blog.id).handle
  end

  test 'should not update blog with existing title' do
    service = AdminServices::Blog::ChangeBlog.
                run(id: @blog.id.to_s, title: @blog2.title, shop_id: @shop.id,
                    page_title: "Changed page_title", handle: "ChangedC handle",
                    meta_description: "Changed meta_description")
    refute service.valid?
    assert_equal 1, service.blog.errors.full_messages.count
    assert_equal "Title has already been taken", service.blog.errors.full_messages.first
  end

  test 'should not update blog with existing handle' do
    service = AdminServices::Blog::ChangeBlog.
                run(id: @blog.id.to_s, title: "some title", shop_id: @shop.id,
                    page_title: "Changed page_title", handle: @blog2.handle,
                    meta_description: "Changed meta_description")
    refute service.valid?
    assert_equal 1, service.blog.errors.full_messages.count
    assert_equal "Handle has already been taken", service.blog.errors.full_messages.first
  end

  test 'should update blog with some blank params' do
    service = AdminServices::Blog::ChangeBlog.
                run(id: @blog2.id.to_s, title: @blog2.title, shop_id: @shop.id,
                    page_title: "", handle: "", meta_description: "")
    assert service.valid?
    assert_equal '', service.blog.handle
    assert_equal '', service.blog.page_title
  end

end
