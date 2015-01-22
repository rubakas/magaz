require 'test_helper'

class Admin::SubscriberNotificationsStoriesTest < ActionDispatch::IntegrationTest
  setup do
    login
    click_link "Settings"
  end
end
