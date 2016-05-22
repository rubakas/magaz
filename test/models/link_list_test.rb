require 'test_helper'

class LinkListTest < ActiveSupport::TestCase
  should have_many  :links
  belong_to         :shop
end

