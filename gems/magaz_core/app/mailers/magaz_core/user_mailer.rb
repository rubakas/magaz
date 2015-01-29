module MagazCore
  class UserMailer < ApplicationMailer
    default :from => ADRESS_SETTINGS[:from]
     default :to => ADRESS_SETTINGS[:to]

    def notification(subscriber_notification, email_template)
      mail(to: subscriber_notification.subscription_address,
           body: email_template.body,
           content_type: "text/html",
           subject: email_template.title)
    end

    def test_notification(subscriber_notification)
      @subscriber_notification = subscriber_notification
      mail(to: subscriber_notification.subscription_address, subject: 'Test Notification')
    end
  end
end
