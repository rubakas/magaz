# == Schema Information
#
# Table name: order_subscriptions
#
#  id                   :integer          not null, primary key
#  notification_method  :string
#  subscription_address :string
#  shop_id              :integer
#  created_at           :datetime
#  updated_at           :datetime
#

require 'test_helper'

class SubscriberNotificationTest < ActiveSupport::TestCase
  should belong_to(:shop)
end
