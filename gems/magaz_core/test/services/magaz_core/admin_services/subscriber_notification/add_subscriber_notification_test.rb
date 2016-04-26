require 'test_helper'

class MagazCore::AdminServices::SubscriberNotification::AddSubscriberNotificationTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: "New shop")
    @subscriber_notification = create(:subscriber_notification, shop: @shop)
    @phone_params = {shop_id: @shop.id,
                     notification_method: "phone",
                     subscription_address: "9379992"}
    @email_params = {shop_id: @shop.id,
                     notification_method: "email",
                     subscription_address: "valid@email.com"}
    @blank_params = {shop_id: "",
                     notification_method: "",
                     subscription_address: ""}
  end

  test "should add subscriber notification with valid phone params" do
    assert_equal 1, MagazCore::SubscriberNotification.count
    service = MagazCore::AdminServices::SubscriberNotification::AddSubscriberNotification.run(@phone_params)
    assert service.valid?
    assert MagazCore::SubscriberNotification.find(service.result.id)
    assert_equal 2, MagazCore::SubscriberNotification.count
    assert_equal @phone_params[:subscription_address],
      MagazCore::SubscriberNotification.find(service.result.id).subscription_address
  end

  test "should add subscriber notification with valid email params" do
    assert_equal 1, MagazCore::SubscriberNotification.count
    service = MagazCore::AdminServices::SubscriberNotification::AddSubscriberNotification.run(@email_params)
    assert service.valid?
    assert MagazCore::SubscriberNotification.find(service.result.id)
    assert_equal 2, MagazCore::SubscriberNotification.count
    assert_equal @email_params[:subscription_address],
      MagazCore::SubscriberNotification.find(service.result.id).subscription_address
  end

  test "should not add subscriber notification with blank params" do
    assert_equal 1, MagazCore::SubscriberNotification.count
    service = MagazCore::AdminServices::SubscriberNotification::AddSubscriberNotification.run(@blank_params)
    refute service.valid?
    assert_equal 1, service.errors.full_messages.count
    assert_equal "Shop is not a valid integer", service.errors.full_messages.first
    assert_equal 1, MagazCore::SubscriberNotification.count
  end

  test "shoul not add subscriber notification with invalid phone" do
    @phone_params[:subscription_address] = "not a number"
    assert_equal 1, MagazCore::SubscriberNotification.count
    service = MagazCore::AdminServices::SubscriberNotification::AddSubscriberNotification.run(@phone_params)
    refute service.valid?
    assert_equal 1, service.errors.full_messages.count
    assert_equal "Subscription address is not a number", service.errors.full_messages.first
    assert_equal 1, MagazCore::SubscriberNotification.count
  end

  test "shoul not add subscriber notification with invalid email" do
    @email_params[:subscription_address] = "wrong email"
    assert_equal 1, MagazCore::SubscriberNotification.count
    service = MagazCore::AdminServices::SubscriberNotification::AddSubscriberNotification.run(@email_params)
    refute service.valid?
    assert_equal 1, service.errors.full_messages.count
    assert_equal "Subscription address is invalid", service.errors.full_messages.first
    assert_equal 1, MagazCore::SubscriberNotification.count
  end

  test "shoul not add subscriber notification with too long email" do
    @email_params[:subscription_address] = "loooooooooooooooooong@email.com"
    assert_equal 1, MagazCore::SubscriberNotification.count
    service = MagazCore::AdminServices::SubscriberNotification::AddSubscriberNotification.run(@email_params)
    refute service.valid?
    assert_equal 1, service.errors.full_messages.count
    assert_equal "Subscription address is too long (maximum is 30 characters)", service.errors.full_messages.first
    assert_equal 1, MagazCore::SubscriberNotification.count
  end

  test "shoul not add subscriber notification with existing email" do
    @email_params[:subscription_address] = @subscriber_notification.subscription_address    
    assert_equal 1, MagazCore::SubscriberNotification.count
    service = MagazCore::AdminServices::SubscriberNotification::AddSubscriberNotification.run(@email_params)
    refute service.valid?
    assert_equal 1, service.errors.full_messages.count
    assert_equal "Email has already been taken", service.errors.full_messages.first
    assert_equal 1, MagazCore::SubscriberNotification.count
  end

end