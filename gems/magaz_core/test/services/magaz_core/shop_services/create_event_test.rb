require 'test_helper'

module MagazCore
  class ShopServices::CreateEventTest < ActiveSupport::TestCase
    setup do
      @shop = create(:shop, subdomain: 'example')
      @user = create(:user, shop: @shop)
      @blog = create(:blog, shop: @shop, handle: "handle1")
      @product = create(:product, shop: @shop)
      @article = create(:article, blog: @blog, handle: "handle1")
      @collection = create(:collection, shop: @shop, handle: "handle1")
    end

    test 'create event with product' do
      service = MagazCore::ShopServices::CreateEvent.call(subject: @product,
                                                          message: "Some some created",
                                                          description: "The product was created",
                                                          verb: 'create')
      assert service.event.persisted?
      assert_equal service.event.subject_id, @product.id
      assert_equal service.event.subject_type, "MagazCore::Product"
      assert_equal service.event.shop_id, @shop.id
      assert_includes service.event.arguments, @product.name
      assert_equal service.event.message, "Some some created"
      assert_equal service.event.description, "The product was created"
      assert_equal service.event.verb, 'create'
    end

    test 'create event with article' do
      service = MagazCore::ShopServices::CreateEvent.call(subject: @article,
                                                          message: "Some some created",
                                                          description: "The article was created",
                                                          verb: 'create')
      assert service.event.persisted?
      assert_equal service.event.subject_id, @article.id
      assert_equal service.event.subject_type, "MagazCore::Article"
      assert_equal service.event.shop_id, @shop.id
      assert_equal service.event.message, "Some some created"
      assert_equal service.event.description, "The article was created"
      assert_equal service.event.verb, 'create'
    end

    test 'create event with collection' do
      service = MagazCore::ShopServices::CreateEvent.call(subject: @collection,
                                                          message: "Some some created",
                                                          description: "The collection was created",
                                                          verb: 'create')
      assert service.event.persisted?
      assert_equal service.event.subject_id, @collection.id
      assert_equal service.event.subject_type, "MagazCore::Collection"
      assert_equal service.event.shop_id, @shop.id
      assert_includes service.event.arguments, @collection.name
      assert_equal service.event.message, "Some some created"
      assert_equal service.event.description, "The collection was created"
      assert_equal service.event.verb, 'create'
    end
  end
end