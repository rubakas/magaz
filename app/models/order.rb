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

class Order < ActiveRecord::Base
  STATUSES = %q[open cancelled]
  FINANCIAL_STATUSES = %q[authorized paid pending refunded partially_paid partially_refunded unpaid voided]
  FULFILLMENT_STATUSES = %q[fulfilled not_fulfilled partially_fulfilled unfulfilled]
  
  has_many :line_items
  belongs_to :shop

  include ShoppingCart
end
