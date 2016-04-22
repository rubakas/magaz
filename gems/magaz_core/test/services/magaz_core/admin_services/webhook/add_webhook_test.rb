require 'test_helper'

class MagazCore::AdminServices::Webhook::AddWebhookTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop)
    @success_params = {shop_id: @shop.id,
                       topic: "create_product_event",
                       format: "JSON",
                       address: "https://www.examplee.com"}
    @blank_params = {shop_id: "",
                     topic: "",
                     format: "",
                     address: ""}
  end

  test "should create webhook with valid params" do
    assert_equal 0, MagazCore::Webhook.count
    service = MagazCore::AdminServices::Webhook::AddWebhook.run(@success_params)
    assert service.valid?
    assert MagazCore::Webhook.find_by_id(service.result.id)
    assert_equal @success_params[:address], MagazCore::Webhook.find_by_id(service.result.id).address
    assert_equal 1, MagazCore::Webhook.count
  end

  test "should not create webhook with blank params" do
    assert_equal 0, MagazCore::Webhook.count
    service = MagazCore::AdminServices::Webhook::AddWebhook.run(@blank_params)
    refute service.valid?
    assert_equal 1, service.errors.count
    assert_equal "Shop is not a valid integer", service.errors.full_messages.first
    assert_equal 0, MagazCore::Webhook.count
  end

  test "should not create webhook with invalid address" do
    assert_equal 0, MagazCore::Webhook.count
    @success_params[:address] = "invalid_adress"
    service = MagazCore::AdminServices::Webhook::AddWebhook.run(@success_params)
    refute service.valid?
    assert_equal 1, service.errors.count
    assert_equal "Address is invalid", service.errors.full_messages.first
    assert_equal 0, MagazCore::Webhook.count
  end
end