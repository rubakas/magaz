# == Schema Information
#
# Table name: files
#
#  id         :integer          not null, primary key
#  file       :string
#  name       :string
#  shop_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  file_size  :integer
#

require 'test_helper'

class AssetFileTest < ActiveSupport::TestCase

  # associations
  should belong_to(:shop)

  # validations
  should validate_presence_of(:shop_id)
  should validate_presence_of(:name)
  should validate_presence_of(:file)
end
