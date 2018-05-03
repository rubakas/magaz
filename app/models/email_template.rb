# == Schema Information
#
# Table name: email_templates
#
#  id            :integer          not null, primary key
#  name          :string
#  title         :string
#  body          :text
#  created_at    :datetime
#  updated_at    :datetime
#  shop_id       :integer
#  template_type :string
#  description   :string
#

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
