# == Schema Information
#
# Table name: line_items
#
#  id          :integer          not null, primary key
#  checkout_id :integer
#  product_id  :integer
#  name        :string
#  description :text
#  price       :decimal(38, 2)
#  quantity    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

module MagazCore
  class LineItem < ActiveRecord::Base
    self.table_name = 'line_items'
    belongs_to :checkout
    belongs_to :product

    def line_price
      if price.nil?
        0
      else
        price * quantity
      end
    end

    def line_weight
      grams * quantity
    end
  end
end
