require 'test_helper'

class AssetFileTest < ActiveSupport::TestCase

  # associations
  should belong_to(:shop)

  # validations
  should validate_presence_of(:shop_id)
  should validate_presence_of(:name)
  should validate_presence_of(:file)
end
