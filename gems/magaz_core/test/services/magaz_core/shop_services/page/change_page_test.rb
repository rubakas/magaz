require 'test_helper'

class MagazCore::ShopServices::Page::ChangePageTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @page = create(:page, shop: @shop)
    @page2 = create(:page, shop: @shop)
    @success_params = { id: @page.id, title: "Changed title", shop_id: @shop.id,
                        page_title: "Changed page_title", handle: "Changed handle",
                        meta_description: "Changed meta_description", content: "Changed content" }
  end

  test 'should update page with valid params' do
    service = MagazCore::ShopServices::Page::ChangePage.run(@success_params)
    assert service.valid?
    assert_equal "Changed page_title", MagazCore::Page.find(@page.id).page_title
    assert_equal 'Changed title', MagazCore::Page.find(@page.id).title
    assert_equal "Changed handle", MagazCore::Page.find(@page.id).handle
  end

  test 'should not update page with existing title' do
    service = MagazCore::ShopServices::Page::ChangePage.
                run(id: @page.id, title: @page2.title, shop_id: @shop.id,
                    page_title: "Changed page_title", handle: "ChangedC handle",
                    meta_description: "Changed meta_description", content: "Changed content")
    refute service.valid?
    assert_equal 1, service.errors.full_messages.count
    assert_equal "Title has already been taken", service.errors.full_messages.first
  end

  test 'should update page with some blank params' do
    service = MagazCore::ShopServices::Page::ChangePage.
                run(id: @page2.id, title: @page2.title, shop_id: @shop.id,
                    page_title: '', handle: '', meta_description: '',
                    content: '')
    assert service.valid?
    assert_equal '', service.result.handle
    assert_equal '', service.result.page_title
  end
end
