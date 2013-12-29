# == Schema Information
#
# Table name: line_items
#
#  id          :integer          not null, primary key
#  order_id    :integer
#  product_id  :integer
#  name        :string(255)
#  description :text
#  price       :decimal(38, 2)
#  quantity    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  def line_price
    price * quantity
  end

  def line_weight
    grams * quantity
  end
end
