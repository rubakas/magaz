require 'test_helper'

class ThemeStyleTest < ActiveSupport::TestCase

  should belong_to(:theme)
  should validate_presence_of(:image)
  should validate_presence_of(:name)
  should validate_presence_of(:theme_id)
  should validate_uniqueness_of(:name).scoped_to(:theme_id)

end
