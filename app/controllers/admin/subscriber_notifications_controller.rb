class Admin::SubscriberNotificationsController < ApplicationController
  include MagazCore::Concerns::Authenticable

  def new
    @shop = current_shop
    @subscriber_notification = @shop.subscriber_notifications.new
  end

  def create
    @shop = current_shop
    @subscriber_notification = @shop.subscriber_notifications.new(permitted_params[:subscriber_notification])
    if @subscriber_notification.save
      flash[:notice] = 'Order notification was added successfully.'
      redirect_to notifications_settings_admin_settings_path 
    else
      render 'new'
    end
  end

  def destroy
    @shop = current_shop
    @subscriber_notification = @shop.subscriber_notifications.find(params[:id])
    @subscriber_notification.destroy
    flash[:notice] = 'Order notification was successfully deleted.'
    redirect_to notifications_settings_admin_settings_path 
  end

  protected

  def permitted_params
    { subscriber_notification:
        params.fetch(:subscriber_notification, {}).permit(:notification_method, 
                                                          :subscription_address) }
  end
end
