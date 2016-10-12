class Admin::SubscriberNotificationsController < Admin::ApplicationController
  include Concerns::Authenticable

  def new
    @subscriber_notification = current_shop.subscriber_notifications.new
  end

  def create
    service = AdminServices::SubscriberNotification::AddSubscriberNotification
              .new(shop_id: current_shop.id, subscriber_notification_params: {
                   notification_method: params[:subscriber_notification][:notification_method],
                   subscription_address: params[:subscriber_notification][:subscription_address]})
              .run
    @subscriber_notification = service.subscriber_notification
    if service.success?
      flash[:notice] = t('.notice_success')
      redirect_to notifications_settings_admin_settings_path
    else
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
