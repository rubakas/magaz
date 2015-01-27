require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  def setup
    @shop = MagazCore::Shop.new
    @email_template = @shop.email_templates.new(name: 'Order Notification', 
                                               title: 'New order', 
                                               body: 'You have a new order', 
                                               template_type: 'new_order_notification' )
    @subscriber = @shop.subscriber_notifications.new(:notification_method => 'email', 
                                                       :subscription_address => 'bozya003@gmail.com')
    @subscriber2 = @shop.subscriber_notifications.new(:notification_method => 'email', 
                                                       :subscription_address => 'duchess@example.gov')
    @subscribers = @shop.subscriber_notifications.all 
  end

  test "test notification to email" do
    if @subscriber.notification_method == 'email'
      mail = MagazCore::UserMailer.test_notification(@subscriber)
      assert_equal 'Test Notification', mail.subject
      assert_equal [@subscriber.subscription_address], mail.to
      assert_equal ["magazmailer@gmail.com"], mail.from
    end
  end

  test "test new order notification" do
    mail = MagazCore::UserMailer.notification(@subscribers, @email_template)
    @subscribers.each do |s|
      assert_equal ["magazmailer@gmail.com"], mail.from 
      assert_equal @email_template.title, mail.subject
      assert_equal s.budy, mail.body 
      assert_equal [s.subscription_address], mail.to
    end
  end
end
