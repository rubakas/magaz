class EmailTemplate < ActiveRecord::Base
  EMAIL_TEMPLATES = %w[ abandoned_checkout_notification
                        contact_buyer fulfillment_request
                        gift_card_notification
                        new_order_notification
                        new_order_notification_mobile
                        order_cancelled order_confirmation
                        refund_notification
                        shipping_confirmation
                        shipping_update ].freeze

  belongs_to :shop

  validates :title, :body, presence: true
end
