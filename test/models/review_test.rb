require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  should belong_to(:theme)
  should belong_to(:user)
end
