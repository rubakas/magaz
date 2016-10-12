require 'test_helper'

class AdminServices::Webhook::DeleteWebhookTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop)
    @webhook = create(:webhook, shop: @shop)
    @webhook2 = create(:webhook, shop: @shop)
  end

  test "should delete webhook with valid ids" do
    assert_equal 2, Webhook.count
    service = AdminServices::Webhook::DeleteWebhook
              .new( id: @webhook.id,
                    shop_id: @shop.id)
              .run
    assert service.success?
    refute Webhook.find_by_id(@webhook.id)
    assert Webhook.find_by_id(@webhook2.id)
    assert_equal 1, Webhook.count
  end

  test 'should rise exeption with blank ids' do
    assert_raises ActiveRecord::RecordNotFound do
      AdminServices::Webhook::DeleteWebhook.new.run
    end
  end

end
