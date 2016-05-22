require 'test_helper'

class ProductImageTest < ActiveSupport::TestCase
  should belong_to(:product)
  # test "the truth" do
  #   assert true
  # end
end
