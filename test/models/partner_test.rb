require 'test_helper'

class PartnerTest < ActiveSupport::TestCase

  should have_many(:themes).dependent(:destroy)
  
end
