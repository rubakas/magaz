class AdminServices::SubscriberNotification::DeleteSubscriberNotification < ActiveInteraction::Base

  integer :id, :shop_id

  validates :id, :shop_id, presence: true

  def execute
    Shop.find(shop_id).subscriber_notifications.find(id).destroy
  end

end
