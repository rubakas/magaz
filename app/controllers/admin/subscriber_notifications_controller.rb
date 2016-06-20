class Admin::SubscriberNotificationsController < Admin::ApplicationController
  include Concerns::Authenticable

  def new
    @subscriber_notification = current_shop.subscriber_notifications.new
  end

  def create
    service = AdminServices::SubscriberNotification::AddSubscriberNotification
              .run(shop_id: current_shop.id,
                   notification_method: params[:subscriber_notification][:notification_method],
                   subscription_address: params[:subscriber_notification][:subscription_address])
    if service.valid?
      @subscriber_notification = service.result
      flash[:notice] = t('.notice_success')
      redirect_to notifications_settings_admin_settings_path
    else
      @subscriber_notification = service.subscriber_notification
      flash.now[:notice] = t('.notice_fail')
      render 'new'
    end
  end

  def destroy
    AdminServices::SubscriberNotification::DeleteSubscriberNotification
    .run(id: params[:id],
         shop_id: current_shop.id)
    flash.now[:notice] = t('.notice_success')
    redirect_to notifications_settings_admin_settings_path
  end

  def send_test_notification
    @shop = current_shop
    @subscriber_notification = @shop.subscriber_notifications.find(params[:id])
    if(@subscriber_notification.notification_method == "email")
      UserMailer.test_notification(@subscriber_notification).deliver_now
      flash[:notice] = t('.notice_success')
      redirect_to admin_notifications_settings_settings_path
    else
      flash[:notice] = t('.notice_success')
      redirect_to notifications_settings_admin_settings_path
    end
  end

end
