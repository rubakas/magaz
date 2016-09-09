require 'test_helper'

class PartnerTest < ActiveSupport::TestCase

  # associations
  should have_many(:themes).dependent(:destroy)
  should have_many(:theme_styles).through(:themes)

  # validations
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name)
  should validate_presence_of(:website_url)
  should validate_uniqueness_of(:website_url)

end
