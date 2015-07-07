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

module MagazCore
  class CommentTest < ActiveSupport::TestCase

    should validate_uniqueness_of(:author).scoped_to(:article_id)
    should validate_presence_of(:author)
    should validate_presence_of(:email)
    should validate_presence_of(:body)
    should belong_to(:article)
    should belong_to(:blog)
    should have_many(:events)

  end
end
