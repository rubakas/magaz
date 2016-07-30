require 'test_helper'

class AdminServices::Page::ChangePageTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @page = create(:page, shop: @shop)
    @page2 = create(:page, shop: @shop, handle: "Handle")
    @success_params = { title: "Changed title", page_title: "Changed page_title", handle: "Changed handle",
                        meta_description: "Changed meta_description", content: "Changed content" }
    @blank_params = { title: @page.title, page_title: '', handle: '',
                      meta_description: '', content: '' }
  end

  test 'should update page with valid params' do
    service = AdminServices::Page::ChangePage
              .new(id: @page.id, shop_id: @shop.id, params: @success_params)
              .run
    assert service.success?
    assert_equal "Changed page_title", Page.find(@page.id).page_title
    assert_equal 'Changed title', Page.find(@page.id).title
    assert_equal "Changed handle", Page.find(@page.id).handle
  end

  test 'should not update page with existing title' do
    invalid_params = @success_params.merge({ title: @page2.title })
    service = AdminServices::Page::ChangePage
                  .new(id: @page.id, shop_id: @shop.id, params: invalid_params)
                  .run
    refute service.success?
    assert_equal 1, service.result.errors.full_messages.count
    assert_equal "Title has already been taken", service.result.errors.full_messages.first
  end

  test 'should update page with some blank params' do
    service = AdminServices::Page::ChangePage
              .new(id: @page.id, shop_id: @shop.id, params: @blank_params)
              .run
    assert service.success?
    assert_equal '', service.result.handle
    assert_equal '', service.result.page_title
  end
end
