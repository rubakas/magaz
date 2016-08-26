require 'test_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

class AdminServices::Webhook::EventWebhookRunnerTest < ActiveSupport::TestCase
  setup do
    @shop = create(:shop, subdomain: 'example')
    @user = create(:user, shop: @shop)
    @webhook1 = create(:webhook, shop: @shop)
    @webhook2 = create(:webhook, shop: @shop)

    @webhook3 = create(:webhook, shop: @shop)
    @webhook3.update_attributes!(topic: Webhook::Topics::CREATE_PRODUCT_EVENT)

    @product = create(:product, shop: @shop)
    @event = create(:event, shop: @shop, subject: @product)
  end

  test 'should not throw error and schedule 2 webhooks' do
    assert_nothing_raised do
      Sidekiq::Worker.clear_all
      service = AdminServices::Webhook::EventWebhookRunner
                .call(event: @event, topic: @webhook1.topic)
      assert_equal 2, WebhookWorker.jobs.size
    end
  end

  test 'should schedule webhook' do
    Sidekiq::Worker.clear_all
    WebhookWorker.perform_async(@webhook1.id, @event.id)
    assert_equal 1, WebhookWorker.jobs.size
  end
end
