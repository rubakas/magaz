require 'test_helper'

class Admin::SubscriberNotificationsStoriesTest < ActionDispatch::IntegrationTest
  setup do
    login
    click_link "Settings"
    click_link "Notifications"
  end

  test "settings form" do
    assert page.has_content? 'Notifications Settings'
  end
end
