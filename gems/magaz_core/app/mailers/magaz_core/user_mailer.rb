module MagazCore
  class UserMailer < ApplicationMailer
    include Rails.application.routes.url_helpers

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

    def invite_new_user(user, host)
      @user = user
      UserMailer.default_url_options[:host] = host
      @shop = MagazCore::Shop.find_by_id(@user.shop_id)
      mail(to: @user.email,
           subject: t('.subject'))
    end
  end
end
