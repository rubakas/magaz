require 'test_helper'

class BlogTest < ActiveSupport::TestCase
  should have_many(:articles)
  should have_many(:comments)
  should have_many(:events)
  should belong_to(:shop)
  should validate_presence_of(:title)
  should validate_presence_of(:shop_id)
  should validate_uniqueness_of(:title).scoped_to(:shop_id)
end
