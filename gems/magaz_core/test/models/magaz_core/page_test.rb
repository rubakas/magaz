require 'test_helper'

module MagazCore
  class PageTest < ActiveSupport::TestCase
    include MagazCore::Shared::VisibilityExamples
    
    setup do
      setup_visibility_examples(model_class: MagazCore::Page, factory_name: :page)
    end

    test 'two pages with same handle and different shops' do
      @shop1 = create(:shop, name: "shop1")
      @shop2 = create(:shop, name: "shop2")
      @page1 = create(:page, title: "page", handle: "page-handle", shop: @shop1)

      @page2 = @shop2.pages.new(title: "page", handle: "page-handle")

      assert @page2.save
      assert @page1.slug == @page2.slug
    end

    test 'two pages with same handle and same shop' do
      @shop1 = create(:shop, name: "shop1")

      @page1 = create(:page, title: "page1", handle: "page-handle", shop: @shop1)

      @page2 = @shop1.pages.new(title: "page2", handle: "page-handle")
      @page2.save

      assert @page2.save
      refute @page1.slug == @page2.slug
    end
  end
end