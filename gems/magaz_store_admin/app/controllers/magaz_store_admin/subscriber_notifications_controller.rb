module MagazStoreAdmin
  class SubscriberNotificationsController < ApplicationController
    include MagazCore::Concerns::Authenticable

    def new
      @subscriber_notification = current_shop.subscriber_notifications.new
    end

    def create
      service = MagazCore::AdminServices::SubscriberNotification::AddSubscriberNotification
                  .run(shop_id: current_shop.id,
                       notification_method: params[:subscriber_notification][:notification_method],
                       subscription_address: params[:subscriber_notification][:subscription_address])
      if service.valid?
        @subscriber_notification = service.result
        flash[:notice] = t('.notice_success')
        redirect_to notifications_settings_settings_path
      else
        @subscriber_notification = service.subscriber_notification
        flash.now[:notice] = t('.notice_fail')
        render 'new'
      end
    end

    def destroy
      MagazCore::AdminServices::SubscriberNotification::DeleteSubscriberNotification
        .run(id: params[:id],
             shop_id: current_shop.id)
      flash.now[:notice] = t('.notice_success')
      redirect_to notifications_settings_settings_path
    end

    def send_test_notification
      @shop = current_shop
      @subscriber_notification = @shop.subscriber_notifications.find(params[:id])
      if(@subscriber_notification.notification_method == "email")
        MagazCore::UserMailer.test_notification(@subscriber_notification).deliver_now
        flash[:notice] = t('.notice_success')
        redirect_to notifications_settings_settings_path
      else
        flash[:notice] = t('.notice_success')
        redirect_to notifications_settings_settings_path
      end
    end

  end
end
