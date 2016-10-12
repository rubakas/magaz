require 'test_helper'

class BlogTest < ActiveSupport::TestCase
  # associations
  should have_many(:articles)
  should have_many(:comments)
  should belong_to(:shop)

  # validations
  should validate_presence_of(:shop_id)
  should validate_presence_of(:title)
  should validate_uniqueness_of(:title).scoped_to(:shop_id)
end
