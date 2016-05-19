require 'test_helper'

class AdminServices::Webhook::ChangeWebhookTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop)
    @webhook = create(:webhook, shop: @shop)
    @success_params = {id: @webhook.id,
                       shop_id: @shop.id,
                       topic: "create_product_event",
                       format: "JSON",
                       address: "https://www.examplee.com"}
    @blank_params = {id: @webhook.id,
                     shop_id: @shop.id,
                     topic: "",
                     format: "",
                     address: ""}
  end

  test "should create webhook with valid params" do
    assert_equal 1, Webhook.count
    service = AdminServices::Webhook::ChangeWebhook.run(@success_params)
    assert service.valid?
    assert_equal @success_params[:address], Webhook.find_by_id(@webhook.id).address
    assert_equal @success_params[:topic], Webhook.find_by_id(@webhook.id).topic
  end

  test "should not create webhook with blank params" do
    assert_equal 1, Webhook.count
    service = AdminServices::Webhook::ChangeWebhook.run(@blank_params)
    refute service.valid?
    assert_equal 4, service.webhook.errors.count
    assert_equal "Topic is not included in the list",
                 service.webhook.errors.full_messages.first
    assert_equal "Format is not included in the list",
                 service.webhook.errors.full_messages[1]
    assert_equal "Address can't be blank",
                 service.webhook.errors.full_messages[2]
    assert_equal "Address is invalid",
                 service.webhook.errors.full_messages.last
  end

  test "should not create webhook with invalid address" do
    assert_equal 1, Webhook.count
    @success_params[:address] = "invalid_adress"
    service = AdminServices::Webhook::ChangeWebhook.run(@success_params)
    refute service.valid?
    assert_equal 1, service.webhook.errors.count
    assert_equal "Address is invalid", service.webhook.errors.full_messages.first
  end
end
