require 'test_helper'

module MagazCore
  class ShopServices::CreateInviteTest < ActionController::TestCase
    setup do
      @shop = create(:shop, name: 'shop_name')
      @host = request.host
      @email = 'some@email.com'
      @user = create(:user, shop: @shop)
    end

    test 'should create user with token and email' do
      service = MagazCore::ShopServices::CreateInvite.call
      service.create_user_with_email_and_token!(email: @email,
                                                shop: @shop)
      assert service.user.persisted?
      assert_equal @shop.id, service.user.shop_id
      assert_not service.user.invite_token.blank?
      assert_equal @email, service.user.email
    end

    test 'should not pass existed user email' do
      service = MagazCore::ShopServices::CreateInvite.call
      assert_equal service.valid_email(email: @user.email, shop: @shop), false
    end

    test 'should send email' do

      service = MagazCore::ShopServices::CreateInvite.call
      service.create_user_with_email_and_token!(email: @email,
                                                shop: @shop)
      @link = "super_link"
      assert_equal service.send_mail_invite(user: service.user, host: @host, link: @link) , ActionMailer::Base.deliveries.last
    end
  end
end