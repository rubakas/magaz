require 'test_helper'

class AdminServices::SubscriberNotification::AddSubscriberNotificationTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: "New shop")
    @subscriber_notification = create(:subscriber_notification, shop: @shop)
    @phone_params = {
      'notification_method' => "phone",
      'subscription_address'=> "9379992"
    }

    @email_params = {
      'notification_method'   => "email",
      'subscription_address'  => "valid@email.com"
    }

    @blank_params = {
      'notification_method' => "",
      'subscription_address' => ""
    }
  end

  test "should add subscriber notification with valid phone params" do
    assert_equal 1, SubscriberNotification.count
    service = AdminServices::SubscriberNotification::AddSubscriberNotification
              .new(shop_id: @shop.id,
                   subscriber_notification_params: @phone_params)
              .run
    assert service.success?
    assert SubscriberNotification.find(service.subscriber_notification.id)
    assert_equal 2, SubscriberNotification.count
    assert_equal @phone_params['subscription_address'],
      SubscriberNotification.find(service.subscriber_notification.id).subscription_address
  end

  test "should add subscriber notification with valid email params" do
    assert_equal 1, SubscriberNotification.count
    service = AdminServices::SubscriberNotification::AddSubscriberNotification
              .new(shop_id: @shop.id,
                   subscriber_notification_params: @email_params)
              .run
    assert service.success?
    assert SubscriberNotification.find(service.subscriber_notification.id)
    assert_equal 2, SubscriberNotification.count
    assert_equal @email_params['subscription_address'],
      SubscriberNotification.find(service.subscriber_notification.id).subscription_address
  end

  test "should not add subscriber notification with blank params" do
    assert_equal 1, SubscriberNotification.count
    service = AdminServices::SubscriberNotification::AddSubscriberNotification
              .new(shop_id: @shop.id,
                   subscriber_notification_params: @blank_params)
              .run
    refute service.success?
    assert_equal 1, service.subscriber_notification.errors.full_messages.count
    assert_includes service.subscriber_notification.errors.full_messages, "Notification method can't be blank"
    assert_equal 1, SubscriberNotification.count
  end

  test "shoul not add subscriber notification with invalid phone" do
    @phone_params['subscription_address'] = "not a number"
    assert_equal 1, SubscriberNotification.count
    service = AdminServices::SubscriberNotification::AddSubscriberNotification
              .new(shop_id: @shop.id,
                   subscriber_notification_params: @phone_params)
              .run
    refute service.success?
    assert_equal 1, service.subscriber_notification.errors.full_messages.count
    assert_equal "Subscription address is not a number",
                 service.subscriber_notification.errors.full_messages.first
    assert_equal 1, SubscriberNotification.count
  end

  test "shoul not add subscriber notification with invalid email" do
    @email_params['subscription_address'] = "wrong email"
    assert_equal 1, SubscriberNotification.count
    service = AdminServices::SubscriberNotification::AddSubscriberNotification
              .new(shop_id: @shop.id,
                   subscriber_notification_params: @email_params)
              .run
    refute service.success?
    assert_equal 1, service.subscriber_notification.errors.full_messages.count
    assert_equal "Subscription address is invalid",
                 service.subscriber_notification.errors.full_messages.first
    assert_equal 1, SubscriberNotification.count
  end

  test "shoul not add subscriber notification with too long email" do
    @email_params['subscription_address'] = "loooooooooooooooooong@email.com"
    assert_equal 1, SubscriberNotification.count
    service = AdminServices::SubscriberNotification::AddSubscriberNotification
              .new(shop_id: @shop.id,
                   subscriber_notification_params: @email_params)
              .run
    refute service.success?
    assert_equal 1, service.subscriber_notification.errors.full_messages.count
    assert_equal "Subscription address is too long (maximum is 30 characters)",
                 service.subscriber_notification.errors.full_messages.first
    assert_equal 1, SubscriberNotification.count
  end

  test "shoul not add subscriber notification with existing email" do
    @email_params['subscription_address'] = @subscriber_notification.subscription_address
    assert_equal 1, SubscriberNotification.count
    service = AdminServices::SubscriberNotification::AddSubscriberNotification
              .new(shop_id: @shop.id,
                   subscriber_notification_params: @email_params)
              .run
    refute service.success?
    assert_equal 1, service.subscriber_notification.errors.full_messages.count
    assert_equal "Subscription address - Email has already been taken",
                 service.subscriber_notification.errors.full_messages.first
    assert_equal 1, SubscriberNotification.count
  end

end
