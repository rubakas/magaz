# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  body       :text
#  mark       :integer
#  user_id    :integer
#  theme_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  # associations
  should belong_to(:theme)
  should belong_to(:user)

  # validations
  should validate_presence_of(:body)
  should validate_length_of(:body).is_at_least(30).is_at_most(400)
  should validate_presence_of(:mark)
  should validate_presence_of(:theme_id)
  #TODO WTF?
  # should validate_uniqueness_of(:theme_id).scoped_to(:user_id)
  should validate_presence_of(:user_id)

end
