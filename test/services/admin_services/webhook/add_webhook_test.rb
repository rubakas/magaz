require 'test_helper'

class AdminServices::Webhook::AddWebhookTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop)
    @success_params = {
      'topic'   => "create_product_event",
      'format'  => "JSON",
      'address' => "https://www.examplee.com"
    }
    @blank_params = {
      'topic'   => "",
      'format'  => "",
      'address' => ""
    }
  end

  test "should create webhook with valid params" do
    assert_equal 0, Webhook.count
    service = AdminServices::Webhook::AddWebhook
              .new(shop_id: @shop.id,
                    webhook_params: @success_params)
              .run
    assert service.success?
    assert Webhook.find_by_id(service.webhook.id)
    assert_equal @success_params['address'], Webhook.find_by_id(service.webhook.id).address
    assert_equal 1, Webhook.count
  end

  test "should not create webhook with blank params" do
    assert_equal 0, Webhook.count
    service = AdminServices::Webhook::AddWebhook
              .new(shop_id: @shop.id,
                    webhook_params: @blank_params)
              .run
    refute service.success?
    assert_equal 4, service.webhook.errors.count
    assert_includes service.webhook.errors.full_messages, "Topic is not included in the list"
    assert_includes service.webhook.errors.full_messages, "Format is not included in the list"
    assert_includes service.webhook.errors.full_messages, "Address can't be blank"
    assert_includes service.webhook.errors.full_messages, "Address is invalid"
    assert_equal 0, Webhook.count
  end

  test "should not create webhook with invalid address" do
    assert_equal 0, Webhook.count
    @success_params['address'] = "invalid_adress"
    service = AdminServices::Webhook::AddWebhook
              .new(shop_id: @shop.id,
                    webhook_params: @success_params)
              .run
    refute service.success?
    assert_equal 1, service.errors.count
    assert_includes service.errors.full_messages, "Address is invalid"
    assert_equal 0, Webhook.count
  end
end
