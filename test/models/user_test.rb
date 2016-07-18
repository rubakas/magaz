require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should belong_to(:shop)
  should validate_presence_of(:shop_id)
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:email)
  should allow_value("hello@mattbrictson.com").for(:email)
  should_not allow_value("@hello").for(:email)
end
