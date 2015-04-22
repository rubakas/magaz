require 'test_helper'

module MagazCore
  class ShopServices::CreateEventTest < ActiveSupport::TestCase
    setup do
      @shop = create(:shop, subdomain: 'example')
      @user = create(:user, shop: @shop)
      @blog = create(:blog, shop: @shop, handle: "handle1")
      @product = create(:product, shop: @shop)
      @article = create(:article, blog: @blog, handle: "handle1")
      # @comment = create(:comment, article: @article)
      @collection = create(:collection, shop: @shop, handle: "handle1")
      # @page = create(:page, shop: @shop, handle: "handle1")
      # @customer = create(:customer, shop: @shop)
      # @checkout = create(:checkout, customer: @customer)
      # @order = create(:checkout, customer: @customer, status: MagazCore::Checkout::STATUSES.first)
    end

    test 'create event with product' do
      service = MagazCore::ShopServices::CreateEvent.call(subject: @product,
                                                          message: "Some some created",
                                                          description: "The product was created",
                                                          path: '/admin/products/1',
                                                          verb: 'create')
      assert service.event.persisted?
      assert_equal service.event.subject_id, @product.id
      assert_equal service.event.subject_type, "Product"
      assert_equal service.event.shop_id, @shop.id
      assert_includes service.event.arguments, @product.name
      assert_equal service.event.message, "Some some created"
      assert_equal service.event.description, "The product was created"
      assert_equal service.event.path, '/admin/products/1'
      assert_equal service.event.verb, 'create'
    end

    test 'create event with article' do
      service = MagazCore::ShopServices::CreateEvent.call(subject: @article,
                                                          message: "Some some created",
                                                          description: "The article was created",
                                                          path: '/admin/articles/1',
                                                          verb: 'create')
      assert service.event.persisted?
      assert_equal service.event.subject_id, @article.id
      assert_equal service.event.subject_type, "Article"
      assert_equal service.event.shop_id, @shop.id
      assert_equal service.event.message, "Some some created"
      assert_equal service.event.description, "The article was created"
      assert_equal service.event.path, '/admin/articles/1'
      assert_equal service.event.verb, 'create'
    end

    test 'create event with collection' do
      service = MagazCore::ShopServices::CreateEvent.call(subject: @collection,
                                                          message: "Some some created",
                                                          description: "The collection was created",
                                                          path: '/admin/collections/1',
                                                          verb: 'create')
      assert service.event.persisted?
      assert_equal service.event.subject_id, @collection.id
      assert_equal service.event.subject_type, "Collection"
      assert_equal service.event.shop_id, @shop.id
      assert_includes service.event.arguments, @collection.name
      assert_equal service.event.message, "Some some created"
      assert_equal service.event.description, "The collection was created"
      assert_equal service.event.path, '/admin/collections/1'
      assert_equal service.event.verb, 'create'
    end
  end
end