require 'test_helper'

class AdminServices::Blog::AddBlogTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @blog = create(:blog, shop: @shop, handle: "some handle")
    @success_params = { 'title'      => "Test title",
                        'page_title' => "Test page_title",
                        'handle'     => "Test handle",
                        'meta_description' => "Test meta_description"
                      }
    @blank_params =   { 'title'      => "",
                        'page_title' => "",
                        'handle'     => "",
                        'meta_description' => ""
                      }
  end

  test 'should create blog with valid params' do
    assert_equal 1, @shop.blogs.count
    service = AdminServices::Blog::AddBlog
              .new( shop_id:  @shop.id,
                    params:   @success_params)
              .run
    assert service.success?
    assert Blog.find_by_id(service.result.id)
    assert_equal 'Test title', service.result.title
    assert_equal 2, @shop.blogs.count
  end

  test 'should not create blog with same params' do
    assert_equal 1, @shop.blogs.count
    service = AdminServices::Blog::AddBlog
              .new( shop_id: @shop.id,
                    params: @success_params)
              .run
    assert service.success?
    service2 = AdminServices::Blog::AddBlog
              .new( shop_id: @shop.id,
                    params: @success_params)
              .run
    refute service2.success?
    assert_equal 2, @shop.blogs.count
  end

  test 'should not create blog with blank params' do
    assert_equal 1, @shop.blogs.count
    service = AdminServices::Blog::AddBlog
              .new( shop_id: @shop.id,
                    params: @blank_params)
              .run
    refute service.success?
    assert_equal 1, service.result.errors.full_messages.count
    assert_equal 1, @shop.blogs.count
  end

end
