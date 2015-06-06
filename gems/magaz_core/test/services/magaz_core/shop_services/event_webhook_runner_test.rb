require 'test_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

module MagazCore
  class ShopServices::EventWebhookRunnerTest < ActiveSupport::TestCase
    setup do
      @shop = create(:shop, subdomain: 'example')
      @user = create(:user, shop: @shop)
      @webhook1 = create(:webhook, shop: @shop)
      @webhook2 = create(:webhook, shop: @shop)

      @webhook3 = create(:webhook, shop: @shop)
      @webhook3.update_attributes!(topic: "Product creation")

      @product = create(:product, shop: @shop)
      @event = create(:event, shop: @shop, subject: @product)
    end

    test 'should not throw error and schedule 2 webhooks' do
      assert_nothing_raised do
        service = MagazCore::ShopServices::EventWebhookRunner.call(event: @event,
                                                                   webhook: @webhook1.topic)
        assert_equal 2, MagazCore::WebhookWorker.jobs.size
      end
    end

    test 'should schedule webhook' do
      Sidekiq::Worker.clear_all
      mail = @event.to_xml
      format = @webhook1.format.downcase
      address = @webhook1.address
      MagazCore::WebhookWorker.perform_async(mail, address, format)
      assert_equal 1, MagazCore::WebhookWorker.jobs.size
    end
  end
end