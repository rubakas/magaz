# == Schema Information
#
# Table name: blogs
#
#  id               :integer          not null, primary key
#  title            :string
#  shop_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#  handle           :string
#  page_title       :string
#  meta_description :string
#  slug             :string
#

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
