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

require 'test_helper'

module MagazCore
  class LineItemTest < ActiveSupport::TestCase
    #TODO: add test for line_price method nil price case
    
    # test "the truth" do
    #   assert true
    # end
  end
end
