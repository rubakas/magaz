require 'test_helper'

class AssetTest < ActiveSupport::TestCase
  should belong_to(:theme)
end
