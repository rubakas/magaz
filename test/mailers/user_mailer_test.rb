require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  include Rails.application.routes.url_helpers

  def default_url_options
    Rails.application.config.action_mailer.default_url_options
  end

  def setup
    @shop = create(:shop, name: 'shop_name')
    @email_template = @shop.email_templates.new(name: 'Order Notification',
                                                title: 'New order',
                                                body: 'You have a new order',
                                                template_type: 'new_order_notification' )
    @subscriber = @shop.subscriber_notifications.new(:notification_method => 'email',
                                                      :subscription_address => 'bozya003@gmail.com')
    @subscriber2 = @shop.subscriber_notifications.new(:notification_method => 'email',
                                                      :subscription_address => 'duchess@example.gov')
    @subscribers = @shop.subscriber_notifications
    @user = create(:user, shop: @shop)
    @invite = create(:invite, shop_id: @shop.id, sender_id: @user.id)
    @link = new_admin_user_url(invite_token: @invite.token)
  end

  test "test notification to email" do
    mail = MagazCore::UserMailer.test_notification(@subscriber)
    assert_equal 'Test Notification', mail.subject
    assert_equal [@subscriber.subscription_address], mail.to
    assert_equal ["magazmailer@gmail.com"], mail.from
  end

  test "test new order notification" do
    mail = MagazCore::UserMailer.notification(@subscriber, @email_template)
    assert_equal [@subscriber.subscription_address], mail.to
    assert_equal ["magazmailer@gmail.com"], mail.from
    assert_equal @email_template.title, mail.subject
    assert_equal @email_template.body, mail.body.raw_source
  end

  test "quantity of subscribers" do
    assert_equal 2, @subscribers.size
  end

  test "invite new user" do
    mail = MagazCore::UserMailer.invite_new_user(@invite, @link)
    assert_equal [@invite.email], mail.to
    assert_equal ["magazmailer@gmail.com"], mail.from
    assert_equal "You are invited", mail.subject
    assert_match @invite.token, @link
    assert_includes mail.body, @user.last_name
    assert_includes mail.body, @user.first_name
    assert_includes mail.body, @shop.name
    assert_includes mail.body, @link
  end
end
