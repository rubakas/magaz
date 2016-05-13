require 'test_helper'

class MagazCore::AdminServices::Webhook::DeleteWebhookTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop)
    @webhook = create(:webhook, shop: @shop)
    @webhook2 = create(:webhook, shop: @shop)
  end

  test "should delete webhook with valid ids" do
    assert_equal 2, MagazCore::Webhook.count
    service = MagazCore::AdminServices::Webhook::DeleteWebhook.run(id: @webhook.id, 
                                                                   shop_id: @shop.id)
    assert service.valid?
    refute MagazCore::Webhook.find_by_id(@webhook.id)
    assert MagazCore::Webhook.find_by_id(@webhook2.id)
    assert_equal 1, MagazCore::Webhook.count    
  end 

  test "should not delete webhook with blank ids" do
    assert_equal 2, MagazCore::Webhook.count
    service = MagazCore::AdminServices::Webhook::DeleteWebhook.run(id: "", 
                                                                   shop_id: "")
    refute service.valid?
    assert_equal 2, service.errors.full_messages.count
    assert_equal "Id is not a valid integer", service.errors.full_messages.first
    assert_equal "Shop is not a valid integer", service.errors.full_messages.last
    assert_equal 2, MagazCore::Webhook.count
  end 

end
