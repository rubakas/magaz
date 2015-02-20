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
      mail(to: subscriber_notification.subscription_address, subject: t('.subject'))
    end

    def invite_new_user(invite, new_admin_user_url)
      @shop = MagazCore::Shop.find_by_id(invite.shop_id)
      @sender = MagazCore::User.find_by_id(invite.sender_id)
      @link = new_admin_user_url
      mail(to: invite.email,
           subject: t('.subject'))
    end
  end
end
