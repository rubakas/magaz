require 'test_helper'

class AdminServices::Page::AddPageTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @page = create(:page, shop: @shop)
    @success_params = { title: "Test title", page_title: "Test page_title",
                        handle: "Test handle", meta_description: "Test meta_description", content: "Test content" }
    @blank_params =   { title: '', page_title: '',
                        handle: '', meta_description: '', content: '' }
  end

  test 'should create page with valid params' do
    assert_equal 1, @shop.pages.count
    service = AdminServices::Page::AddPage
              .new(shop_id: @shop.id, params: @success_params)
              .run
    assert service.success?
    assert Page.find_by_id(service.result.id)
    assert_equal 'Test title', service.result.title
    assert_equal 2, @shop.pages.count
  end

  test 'should not create page with same params' do
    assert_equal 1, @shop.pages.count
    service = AdminServices::Page::AddPage
              .new(shop_id: @shop.id, params: @success_params)
              .run
    assert service.success?
    service2 = AdminServices::Page::AddPage
                .new(shop_id: @shop.id, params: @success_params)
                .run
    refute service2.success?
    assert_equal 2, @shop.pages.count
    assert_equal 2, service2.result.errors.full_messages.count
    assert_equal "Title has already been taken", service2.result.errors.full_messages.first
    assert_equal "Handle has already been taken", service2.result.errors.full_messages.last
  end

  test 'should not create page with blank params' do
    assert_equal 1, @shop.pages.count
    service = AdminServices::Page::AddPage
              .new(shop_id: @shop.id, params: @blank_params)
              .run
    refute service.success?
    assert_equal 1, service.result.errors.full_messages.count
    assert_equal "Title can't be blank", service.result.errors.full_messages.first
    assert_equal 1, @shop.pages.count
  end
end
