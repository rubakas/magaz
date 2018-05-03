# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string
#  last_name       :string
#  email           :string
#  password_digest :string
#  phone           :string
#  homepage        :string
#  bio             :string
#  shop_id         :integer
#  created_at      :datetime
#  updated_at      :datetime
#  user_type       :string
#  password_salt   :string
#  account_owner   :boolean          default(FALSE)
#  permissions     :string           default([]), is an Array
#  invite_token    :string
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should belong_to(:shop)

  #TODO shoulda don't work with context validation

  # should validate_presence_of(:shop_id)
  # should validate_presence_of(:first_name)
  # should validate_presence_of(:last_name)
  # should validate_presence_of(:email)
  # should allow_value("hello@mattbrictson.com").for(:email)
  # should_not allow_value("@hello").for(:email)
end
