require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  # associations
  should have_many :checkouts
  should belong_to :shop
end
