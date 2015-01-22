require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  def setup
    @shop = MagazCore::Shop.new
    @notification = @shop.subscriber_notifications.new(:notification_method => 'email', :subscription_address => 'duchess@example.gov')
  end

  test "test notification to email" do
    if @notification.notification_method == 'email'
      mail = MagazCore::UserMailer.test_notification(@notification)
      assert_equal 'Test Notification', mail.subject
      assert_equal [@notification.subscription_address], mail.to
      assert_equal ["notifications@example.com"], mail.from
    end
  end
end
