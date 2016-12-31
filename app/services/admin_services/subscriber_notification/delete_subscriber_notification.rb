class AdminServices::SubscriberNotification::DeleteSubscriberNotification

  attr_reader :success, :subscriber_notification, :errors
  alias_method :success?, :success

  def initialize  id: nil, 
                  shop_id: nil
    @subscriber_notification = ::Shop.find(shop_id).subscriber_notifications.find(id)
  end

  def run
    @success = true
    @subscriber_notification.destroy || @success = false
    @errors = @subscriber_notification.errors
    self
  end
end
