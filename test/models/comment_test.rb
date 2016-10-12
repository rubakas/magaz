require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # associations
  should belong_to(:article)
  should belong_to(:blog)
end
