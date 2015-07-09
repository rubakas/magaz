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

module MagazCore
  class ProductImageTest < ActiveSupport::TestCase

    should belong_to(:product)

  end
end
