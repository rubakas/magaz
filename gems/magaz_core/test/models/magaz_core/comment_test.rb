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
    # test "the truth" do
    #   assert true
    # end
  end
end
