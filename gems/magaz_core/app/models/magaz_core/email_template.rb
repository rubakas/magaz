module MagazCore
  class EmailTemplate < ActiveRecord::Base
    belongs_to :shop

    self.table_name = 'email_templates'

    EMAIL_TEMPLATES = %w[abandoned_checkout_notification contact_buyer fulfillment_request gift_card_notification
                         new_order_notification new_order_notification_mobile order_cancelled order_confirmation
                         refund_notification shipping_confirmation shipping_update]
  end
end
