module MagazStoreAdmin
  class SubscriberNotificationsController < ApplicationController
    include MagazCore::Concerns::Authenticable

    def new
      @shop = current_shop
      @subscriber_notification = @shop.subscriber_notifications.new
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
        @subscriber_notification = MagazCore::SubscriberNotification.new
        service.errors.full_messages.each do |msg|
          @subscriber_notification.errors.add(:base, msg)
        end
        render 'new'
      end
    end

    def destroy
      service = MagazCore::AdminServices::SubscriberNotification::DeleteSubscriberNotification
                  .run(id: params[:id],
                       shop_id: current_shop.id)
      flash[:notice] = t('.notice_success')
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

    protected

    def permitted_params
      { subscriber_notification:
          params.fetch(:subscriber_notification, {}).permit(:notification_method,
                                                            :subscription_address) }
    end
  end
end
