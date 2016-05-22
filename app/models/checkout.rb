# == Schema Information
#
# Table name: checkouts
#
#  id                 :integer          not null, primary key
#  note               :text
#  status             :string
#  financial_status   :string
#  fulfillment_status :string
#  currency           :string
#  email              :string
#  created_at         :datetime
#  updated_at         :datetime
#  customer_id        :integer
#


class Checkout < ActiveRecord::Base
  self.table_name = 'checkouts'
  STATUSES = %w[open cancelled]
  # FINANCIAL_STATUSES = %w[authorized
  #                         paid pending partially_paid
  #                         partially_refunded refunded unpaid voided]
  # FULFILLMENT_STATUSES = %w[fulfilled
  #                           not_fulfilled
  #                           partially_fulfilled
  #                           unfulfilled ]

  belongs_to  :customer
  has_many    :events, as: :subject
  has_many    :line_items
  
  scope :orders, -> { where(status: STATUSES) }
  scope :not_orders, -> { where(status: nil) }
  scope :abandoned_checkouts, -> { where("checkouts.email IS NOT NULL") }

  include Concerns::ShoppingCart
end
