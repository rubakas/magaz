require 'test_helper'

module MagazCore
  class ShopServices::CreateInviteTest < ActiveSupport::TestCase
    setup do
      @shop = create(:shop, name: 'shop_name')
      @host = "shop_name.magaz.local:3000"
      @email = 'some@email.com'
    end

    test 'create user with token and email' do
      service = MagazCore::ShopServices::CreateInvite
                  .call(shop: @shop, email: @email, host: @host)
      assert service.user.persisted?
      assert_equal @shop.id, service.user.shop_id
      assert_not service.user.invite_token.blank?
      assert_equal @email, service.user.email
    end
  end
end