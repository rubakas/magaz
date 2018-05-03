# == Schema Information
#
# Table name: link_lists
#
#  id      :integer          not null, primary key
#  name    :string
#  shop_id :integer
#  handle  :string
#  slug    :string
#

require 'test_helper'

class LinkListTest < ActiveSupport::TestCase
  # associations
  should have_many  :links
  belong_to         :shop

  # validations
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name).scoped_to(:shop_id)
  should validate_presence_of(:shop_id)
end
