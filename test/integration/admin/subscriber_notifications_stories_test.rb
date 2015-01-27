require 'test_helper'

class Admin::SubscriberNotificationsStoriesTest < ActionDispatch::IntegrationTest
  setup do
    login
    @subscriber_notification = create(:subscriber_notification, shop: @shop)
    click_link "Settings"
    click_link "Notifications"
  end

  test "notification form" do
    assert page.has_content? 'Notifications'
  end

  test "add subscriber notification" do
    click_link "Add an order notification"
    select('Email address', :from => 'subscriber_notification_notification_method')
    fill_in 'subscriber_notification_subscription_address', with: 'test@test.dev'
    click_button 'Add notification'
    assert page.has_content? 'Order notification was added successfully.'
    assert page.has_content? 'Notifications'
    assert page.has_content? 'Send to email test@test.dev'
  end

  test "should send test notification" do
    assert page.has_content? @subscriber_notification.subscription_address
    click_link 'send test notification'
    assert page.has_content? 'An example order notification has been sent.'
  end

  test "delete subscriber notification" do
    assert page.has_content? 'delete'
    click_link('delete', match: :first)
    assert page.has_no_content? @subscriber_notification.subscription_address
    assert page.has_no_content? 'send test notification'
  end
end
