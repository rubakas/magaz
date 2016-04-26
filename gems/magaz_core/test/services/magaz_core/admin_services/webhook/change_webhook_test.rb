require 'test_helper'

class MagazCore::AdminServices::Webhook::ChangeWebhookTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop)
    @webhook = create(:webhook, shop: @shop)
    @success_params = {id: @webhook.id,
                       shop_id: @shop.id,
                       topic: "create_product_event",
                       format: "JSON",
                       address: "https://www.examplee.com"}
    @blank_params = {id: "",
                     shop_id: "",
                     topic: "",
                     format: "",
                     address: ""}
  end

  test "should create webhook with valid params" do
    assert_equal 1, MagazCore::Webhook.count
    service = MagazCore::AdminServices::Webhook::ChangeWebhook.run(@success_params)
    assert service.valid?
    assert_equal @success_params[:address], MagazCore::Webhook.find_by_id(@webhook.id).address
    assert_equal @success_params[:topic], MagazCore::Webhook.find_by_id(@webhook.id).topic
  end

  test "should not create webhook with blank params" do
    assert_equal 1, MagazCore::Webhook.count
    service = MagazCore::AdminServices::Webhook::ChangeWebhook.run(@blank_params)
    refute service.valid?
    assert_equal 2, service.errors.count
    assert_equal "Shop is not a valid integer", service.errors.full_messages.first
    assert_equal "Id is not a valid integer", service.errors.full_messages.last
  end

  test "should not create webhook with invalid address" do
    assert_equal 1, MagazCore::Webhook.count
    @success_params[:address] = "invalid_adress"
    service = MagazCore::AdminServices::Webhook::ChangeWebhook.run(@success_params)
    refute service.valid?
    assert_equal 1, service.errors.count
    assert_equal "Address is invalid", service.errors.full_messages.first
  end
end