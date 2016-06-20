require 'test_helper'

class AdminServices::Page::ChangePageTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @page = create(:page, shop: @shop)
    @page2 = create(:page, shop: @shop, handle: "Handle")
    @success_params = { id: "#{@page.id}", title: "Changed title", shop_id: @shop.id,
                        page_title: "Changed page_title", handle: "Changed handle",
                        meta_description: "Changed meta_description", content: "Changed content" }
  end

  test 'should update page with valid params' do
    service = AdminServices::Page::ChangePage.run(@success_params)
    assert service.valid?
    assert_equal "Changed page_title", Page.find(@page.id).page_title
    assert_equal 'Changed title', Page.find(@page.id).title
    assert_equal "Changed handle", Page.find(@page.id).handle
  end

  test 'should not update page with existing title' do
    service = AdminServices::Page::ChangePage
              .run(id: "#{@page.id}",
                    title: @page2.title,
                    shop_id: @shop.id,
                    page_title: "Changed page_title",
                    handle: "ChangedC handle",
                    meta_description: "Changed meta_description",
                    content: "Changed content")
    refute service.valid?
    assert_equal 1, service.page.errors.full_messages.count
    assert_equal "Title has already been taken", service.page.errors.full_messages.first
  end

  test 'should not update page with existing handle' do
    service = AdminServices::Page::ChangePage
              .run( id: "#{@page.id}",
                    title: "ChangedTitle",
                    shop_id: @shop.id,
                    page_title: "Changed page_title",
                    handle: @page2.handle,
                    meta_description: "Changed meta_description",
                    content: "Changed content")
    refute service.valid?
    assert_equal 1, service.page.errors.full_messages.count
    assert_equal "Handle has already been taken", service.page.errors.full_messages.first
  end

  test 'should update page with some blank params' do
    service = AdminServices::Page::ChangePage
              .run( id: "#{@page2.id}",
                    title: @page2.title,
                    shop_id: @shop.id,
                    page_title: '',
                    handle: '',
                    meta_description: '',
                    content: '')
    assert service.valid?
    assert_equal '', service.result.handle
    assert_equal '', service.result.page_title
  end
end
