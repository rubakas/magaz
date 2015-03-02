class Admin::SubscriberNotificationsController < ApplicationController
  include MagazCore::Concerns::Authenticable

  def new
    @subscriber_notification = current_shop.subscriber_notifications.new
  end

  def create
    @subscriber_notification = current_shop.subscriber_notifications.new(permitted_params[:subscriber_notification])
    if @subscriber_notification.save
      flash[:notice] = t('.notice')
      redirect_to notifications_settings_admin_settings_path
    else
      render 'new'
    end
  end

  def destroy
    @subscriber_notification = current_shop.subscriber_notifications.find(params[:id])
    @subscriber_notification.destroy
    flash[:notice] = t('.notice')
    redirect_to notifications_settings_admin_settings_path
  end

  def send_test_notification
    @subscriber_notification = current_shop.subscriber_notifications.find(params[:id])
    if(@subscriber_notification.notification_method == "email")
      MagazCore::UserMailer.test_notification(@subscriber_notification).deliver_now
      flash[:notice] = t('.notice')
      redirect_to notifications_settings_admin_settings_path
    else
      flash[:notice] = t('.notice')
      redirect_to notifications_settings_admin_settings_path
    end
  end

  protected

  def permitted_params
    { subscriber_notification:
        params.fetch(:subscriber_notification, {}).permit(:notification_method,
                                                          :subscription_address) }
  end
end
