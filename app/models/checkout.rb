# == Schema Information
#
# Table name: orders
#
#  id                 :integer          not null, primary key
#  shop_id            :integer
#  note               :text
#  status             :string(255)
#  financial_status   :string(255)
#  fulfillment_status :string(255)
#  currency           :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

class Checkout < ActiveRecord::Base
  STATUSES = %w[open cancelled]
  # FINANCIAL_STATUSES = %w[authorized 
  #                         paid pending partially_paid 
  #                         partially_refunded refunded unpaid voided]
  # FULFILLMENT_STATUSES = %w[fulfilled 
  #                           not_fulfilled 
  #                           partially_fulfilled 
  #                           unfulfilled ]
  
  has_many :line_items
  belongs_to :customer

  scope :orders, -> { where(status: STATUSES) }
  scope :not_orders, -> { where(status: nil) }

  include ShoppingCart
end
