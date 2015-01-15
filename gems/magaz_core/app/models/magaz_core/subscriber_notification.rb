module MagazCore
  class SubscriberNotification < ActiveRecord::Base
    before_save :downcase_email

    self.table_name = 'order_subscriptions'
    belongs_to :shop
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :subscription_address, presence: true, length: {maximum: 30 },
                    format: {with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false },
    if: :select_email_address_method?
    
    validates :subscription_address, :numericality => {:only_integer => true}, 
    if: :select_phone_number_method? 

    def downcase_email
      self.subscription_address = subscription_address.downcase
    end

    def select_phone_number_method?
      "phone" == self.notification_method
    end

    def select_email_address_method?
      "email" == self.notification_method
    end
  end
end
