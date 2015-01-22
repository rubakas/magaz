module MagazCore
  class UserMailer < ApplicationMailer
    default from: 'notifications@example.com'

    def notification(subscriber_notifications)
      @subscriber_notifications = subscriber_notifications
      @subscriber_notifications.each do |subscriber|
        mail(to: subscriber.subscription_address, subject: 'New Order')
      end
    end

    def test_notification(subscriber_notification)
      @subscriber_notification = subscriber_notification
      mail(to: subscriber_notification.subscription_address, subject: 'Test Notification')
    end 
  end
end
