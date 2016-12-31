class AdminServices::SubscriberNotification::AddSubscriberNotification

  attr_reader :success, :subscriber_notification, :errors
  alias_method :success?, :success

  def initialize  shop_id: current_shop.id,
                  subscriber_notification_params: {
                    'notification_method'  => nil,
                    'subscription_address' => nil
                  }
    @shop = ::Shop.find(shop_id)
    @subscriber_notification = @shop.subscriber_notifications.new
    @subscriber_notification_params = subscriber_notification_params
  end

  def run
    @subscriber_notification.assign_attributes(downcased_subscriber_notification_params)
    if @subscriber_notification.valid?
      @success = true
      @subscriber_notification.save
    else
      @success = false
      @errors = @subscriber_notification.errors
    end
    self
  end

  private

  def downcased_subscriber_notification_params
    params = @subscriber_notification_params
    params['subscription_address'] = params['subscription_address'].downcase
    params
  end
end
