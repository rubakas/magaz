require 'test_helper'

module MagazCore
  class UserTest < ActiveSupport::TestCase

    should belong_to(:shop)
    should have_many(:events)
    should validate_uniqueness_of(:email)
    should validate_presence_of(:first_name)
    should validate_presence_of(:last_name)

  end
end
