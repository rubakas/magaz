# == Schema Information
#
# Table name: product_images
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  image      :string
#  product_id :integer
#

require 'test_helper'

class ProductImageTest < ActiveSupport::TestCase
  # associations
  should belong_to :product

  # validations
  should validate_presence_of(:image)
  should validate_presence_of(:product_id)
end
