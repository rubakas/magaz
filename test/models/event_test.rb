require 'test_helper'

class EventTest < ActiveSupport::TestCase
  should belong_to :shop
  should belong_to :subject
end