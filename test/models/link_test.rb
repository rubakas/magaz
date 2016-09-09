require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  # associations
  should belong_to :link_list

  # validations
  should validate_presence_of(:name)
  should validate_presence_of(:link_list_id)
  should validate_uniqueness_of(:name).scoped_to(:link_list_id)
end
