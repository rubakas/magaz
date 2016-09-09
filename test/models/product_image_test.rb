require 'test_helper'

class ProductImageTest < ActiveSupport::TestCase
  # associations
  should belong_to :product

  # validations
  should validate_presence_of(:image)
  should validate_presence_of(:product_id)
end
