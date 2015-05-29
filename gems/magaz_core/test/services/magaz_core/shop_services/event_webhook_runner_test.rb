require 'test_helper'

module MagazCore
  class ShopServices::EventWebhookRunnerTest < ActiveSupport::TestCase
    setup do
      @shop = create(:shop, subdomain: 'example')
      @user = create(:user, shop: @shop)
      @webhook = create(:webhook)
      @product = create(:product, shop: @shop)
      @event = create(:event, shop: @shop, subject: @product)
    end

    test 'should not throw error' do
      assert_nothing_raised do
        service = MagazCore::ShopServices::EventWebhookRunner.call(event: @event,
                                                                   webhook: "Product update")
      end
    end
  end
end