require 'test_helper'

class StoreServices::CreateEventCreateEventTest < ActiveSupport::TestCase
  setup do
    @shop       = create(:shop, subdomain: 'example')
    @user       = create(:user, shop: @shop)
    @blog       = create(:blog, shop: @shop, handle: "handle1")
    @product    = create(:product, shop: @shop)
    @article    = create(:article, blog: @blog, handle: "handle1")
    @collection = create(:collection, shop: @shop, handle: "handle1")
    @webhook    = create(:webhook, shop: @shop)
  end

  test 'create event with product' do
    service = StoreServices::CreateEvent
              .run( subject_class:  @product.class.to_s,
                    subject_id:     @product.id,
                    topic:          Webhook::Topics::CREATE_PRODUCT_EVENT,
                    user_id:        @user.id,
                    shop_id:        @shop.id)
    assert service.valid?
    assert_equal service.result.subject_id, @product.id
    assert_equal service.result.subject_type, "Product"
    assert_equal service.result.shop_id, @shop.id
    assert_includes service.result.arguments, @product.name
    assert_equal service.result.message, "#{@user.full_name} created a product: "
    assert_equal service.result.description, "The product was created"
    assert_equal service.result.verb, 'create'
  end

  test 'create event with article' do
    service = StoreServices::CreateEvent
              .run(subject_class: @article.class.to_s,
                    subject_id: @article.id,
                    topic: Webhook::Topics::CREATE_ARTICLE_EVENT,
                    user_id: @user.id,
                    shop_id: @shop.id)
    assert service.valid?
    assert_equal service.result.subject_id, @article.id
    assert_equal service.result.subject_type, "Article"
    assert_equal service.result.shop_id, @shop.id
    assert_equal service.result.message, "#{@user.full_name} created a article: "
    assert_equal service.result.description, "The article was created"
    assert_equal service.result.verb, 'create'
  end

  test 'create event with collection' do
    service = StoreServices::CreateEvent
              .run( subject_class:  @collection.class.to_s,
                    subject_id:     @collection.id,
                    topic:          Webhook::Topics::CREATE_COLLECTION_EVENT,
                    user_id:        @user.id,
                    shop_id:        @shop.id)
    assert service.valid?
    assert_equal service.result.subject_id, @collection.id
    assert_equal service.result.subject_type, "Collection"
    assert_equal service.result.shop_id, @shop.id
    assert_includes service.result.arguments, @collection.name
    assert_equal service.result.message, "#{@user.full_name} created a collection: "
    assert_equal service.result.description, "The collection was created"
    assert_equal service.result.verb, 'create'
  end

  test 'create event with Webhook' do
    service = StoreServices::CreateEvent
              .run( subject_class:  @webhook.class.to_s,
                    subject_id:     @webhook.id,
                    topic:          Webhook::Topics::CREATE_WEBHOOK_EVENT,
                    user_id:        @user.id,
                    shop_id:        @shop.id)
    assert service.valid?
    assert_equal service.result.subject_id, @webhook.id
    assert_equal service.result.subject_type, "Webhook"
    assert_equal service.result.shop_id, @shop.id
    assert_equal service.result.message, "#{@user.full_name} created a webhook: "
    assert_equal service.result.description, "The webhook was created"
    assert_equal service.result.verb, 'create'
  end

  test 'should not create event with wrong topic' do
    service = StoreServices::CreateEvent
              .run( subject_class:  @webhook.class.to_s,
                    subject_id:     @webhook.id,
                    topic:          "wrong_topic",
                    user_id:        @user.id,
                    shop_id:        @shop.id)
    refute service.valid?
    assert_equal "Topic is not included in the list", service.event.errors.full_messages.first
  end

  test 'should not create event with wrong class' do
    service = StoreServices::CreateEvent
              .run( subject_class:  :wrong_class,
                    subject_id:     @webhook.id,
                    topic:          Webhook::Topics::CREATE_WEBHOOK_EVENT,
                    user_id:        @user.id,
                    shop_id:        @shop.id)
    refute service.valid?
    assert_equal "Subject class is not a valid string", service.event.errors.full_messages.first
  end
end
