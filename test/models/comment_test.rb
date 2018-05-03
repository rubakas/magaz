# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  author     :string
#  body       :text
#  email      :string
#  blog_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  article_id :integer
#

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # associations
  should belong_to(:article)
  should belong_to(:blog)
end
