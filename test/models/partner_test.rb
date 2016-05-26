require 'test_helper'

class PartnerTest < ActiveSupport::TestCase

  should have_many(:themes)
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name)
  
end
