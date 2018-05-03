# == Schema Information
#
# Table name: theme_styles
#
#  id               :integer          not null, primary key
#  name             :string
#  image            :string
#  theme_id         :integer
#  created_at       :datetime
#  updated_at       :datetime
#  industry         :string
#  example_site_url :string
#

require 'test_helper'

class ThemeStyleTest < ActiveSupport::TestCase
  # associations
  should belong_to(:theme)

  # validations
  should validate_uniqueness_of(:name).scoped_to(:theme_id)
end
