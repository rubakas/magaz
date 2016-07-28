require 'test_helper'

class LinkListTest < ActiveSupport::TestCase
  should have_many  :links
  belong_to         :shop
  should validate_presence_of(:name)
  should validate_presence_of(:shop_id)
  should validate_uniqueness_of(:name).scoped_to(:shop_id)
  should validate_uniqueness_of(:handle).scoped_to(:shop_id).allow_blank
end

