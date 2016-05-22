require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  should belong_to :checkout
  should belong_to :product
  #TODO: add test for line_price method nil price case
end
