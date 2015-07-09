require 'test_helper'

module MagazCore
  class EventTest < ActiveSupport::TestCase

    should validate_presence_of(:verb)
    should validate_presence_of(:message)
    should validate_presence_of(:subject_id)
    should validate_presence_of(:subject_type)
    should belong_to(:shop)
    should belong_to(:subject)

  end
end
