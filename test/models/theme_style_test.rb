require 'test_helper'

class ThemeStyleTest < ActiveSupport::TestCase
  # associations
  should belong_to(:theme)

  # validations
  should validate_uniqueness_of(:name).scoped_to(:theme_id)
end
