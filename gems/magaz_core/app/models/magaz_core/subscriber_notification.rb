module MagazCore
  class SubscriberNotification < ActiveRecord::Base

    self.table_name = 'order_subscriptions'
    belongs_to :shop

  end
end
