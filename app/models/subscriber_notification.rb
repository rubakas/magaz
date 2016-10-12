class SubscriberNotification < ActiveRecord::Base
  self.table_name = 'order_subscriptions'

  belongs_to :shop

  validates :notification_method,  presence: true
  validates :subscription_address, presence: true, length: {maximum: 30 },
                                   format: { with: Concerns::PasswordAuthenticable::EMAIL_VALID_REGEX},
                                   uniqueness: { scope: :shop_id,
                                                 message: I18n.t('services.add_subscriber_notification.email_not_unique')
                                               },
                                   :if => lambda {self.notification_method == 'email'}
  validates :subscription_address, presence: true, :numericality => {:only_integer => true},
                                   uniqueness: { scope: :shop_id,
                                                 message: I18n.t('services.add_subscriber_notification.mobile_phone_not_unique')
                                               },
                                   :if => lambda {self.notification_method == 'phone'}
end
