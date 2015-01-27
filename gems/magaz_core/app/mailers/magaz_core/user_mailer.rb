module MagazCore
  class UserMailer < ApplicationMailer
    default :from => ADRESS_SETTINGS[:from]
     default :to => ADRESS_SETTINGS[:to]

    def notification(subscriber_notifications, email_template)
      @subscriber_notifications = subscriber_notifications
      @subscriber_notifications.each do |subscriber|
        mail(to: subscriber.subscription_address,
             body: email_template.body,
             content_type: "text/html",
             subject: email_template.title)
      end
    end

    def test_notification(subscriber_notification)
      @subscriber_notification = subscriber_notification
      mail(to: subscriber_notification.subscription_address, subject: 'Test Notification')
    end
  end
end
