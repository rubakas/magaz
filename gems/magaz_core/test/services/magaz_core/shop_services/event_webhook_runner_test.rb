require 'test_helper'

module MagazCore
  class ShopServices::EventWebhookRunnerTest < ActiveSupport::TestCase
    setup do
      @shop = create(:shop, subdomain: 'example')
      @user = create(:user, shop: @shop)
      @webhook1 = create(:webhook, shop: @shop)
      @webhook2 = create(:webhook, shop: @shop)

      @webhook3 = create(:webhook, shop: @shop)
      @webhook3.update_attributes!(topic: "Product creation")
      @webhook4 = create(:webhook, shop: @shop)
      @webhook4.update_attributes!(topic: "Product creation")

      @product = create(:product, shop: @shop)
      @event = create(:event, shop: @shop, subject: @product)
    end

    test 'should not throw error' do
      assert_nothing_raised do
        service = MagazCore::ShopServices::EventWebhookRunner.call(event: @event,
                                                                   webhook: "Product update")
      end
    end

    test 'should schedule webhook' do
      service = MagazCore::ShopServices::EventWebhookRunner.call(event: @event,
                                                                 webhook: @webhook1)
      assert_send([@event, :to_xml])
    end
  end
end