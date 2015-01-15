module MagazCore
  class UserMailer < ApplicationMailer
    default from: 'notifications@example.com'

    def test_notification(subscriber_notification)
      @subscriber_notification = subscriber_notification
      mail(to: subscriber_notification.subscription_address, subject: 'Test Notification')
    end 
  end
end
