require 'test_helper'

class MagazCore::ShopServices::Event::CreateEventCreateEventTest < ActiveSupport::TestCase
  setup do
    @shop = create(:shop, subdomain: 'example')
    @user = create(:user, shop: @shop)
    @blog = create(:blog, shop: @shop, handle: "handle1")
    @product = create(:product, shop: @shop)
    @article = create(:article, blog: @blog, handle: "handle1")
    @collection = create(:collection, shop: @shop, handle: "handle1")
    @webhook = create(:webhook, shop: @shop)
  end

  test 'create event with product' do
    service = MagazCore::ShopServices::Event::CreateEvent
                .call(subject: @product,
                      topic: MagazCore::Webhook::Topics::CREATE_PRODUCT_EVENT,
                      current_user: @user)

    assert service.event.persisted?
    assert_equal service.event.subject_id, @product.id
    assert_equal service.event.subject_type, "MagazCore::Product"
    assert_equal service.event.shop_id, @shop.id
    assert_includes service.event.arguments, @product.name
    assert_equal service.event.message, "#{@user.full_name} created a product: "
    assert_equal service.event.description, "The product was created"
    assert_equal service.event.verb, 'create'
  end

  test 'create event with article' do
    service = MagazCore::ShopServices::Event::CreateEvent
                .call(subject: @article,
                      topic: MagazCore::Webhook::Topics::CREATE_ARTICLE_EVENT,
                      current_user: @user)

    assert service.event.persisted?
    assert_equal service.event.subject_id, @article.id
    assert_equal service.event.subject_type, "MagazCore::Article"
    assert_equal service.event.shop_id, @shop.id
    assert_equal service.event.message, "#{@user.full_name} created a article: "
    assert_equal service.event.description, "The article was created"
    assert_equal service.event.verb, 'create'
  end

  test 'create event with collection' do
    service = MagazCore::ShopServices::Event::CreateEvent
                .call(subject: @collection,
                      topic: MagazCore::Webhook::Topics::CREATE_COLLECTION_EVENT,
                      current_user: @user)

    assert service.event.persisted?
    assert_equal service.event.subject_id, @collection.id
    assert_equal service.event.subject_type, "MagazCore::Collection"
    assert_equal service.event.shop_id, @shop.id
    assert_includes service.event.arguments, @collection.name
    assert_equal service.event.message, "#{@user.full_name} created a collection: "
    assert_equal service.event.description, "The collection was created"
    assert_equal service.event.verb, 'create'
  end

  test 'create event with Webhook' do
    service = MagazCore::ShopServices::Event::CreateEvent
                .call(subject: @webhook,
                      topic: MagazCore::Webhook::Topics::CREATE_WEBHOOK_EVENT,
                      current_user: @user)

    assert service.event.persisted?
    assert_equal service.event.subject_id, @webhook.id
    assert_equal service.event.subject_type, "MagazCore::Webhook"
    assert_equal service.event.shop_id, @shop.id
    assert_equal service.event.message, "#{@user.full_name} created a webhook: "
    assert_equal service.event.description, "The webhook was created"
    assert_equal service.event.verb, 'create'
  end
end
