require 'test_helper'

class MagazCore::AdminServices::SubscriberNotification::DeleteSubscriberNotificationTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @first_subscriber_notification = create(:subscriber_notification, shop: @shop)
    @second_subscriber_notification = create(:subscriber_notification, shop: @shop)
  end

  test 'should delete subscriber notification with valid ids' do
    assert_equal 2, @shop.subscriber_notifications.count
    service = MagazCore::AdminServices::SubscriberNotification::DeleteSubscriberNotification
                .run(id: @first_subscriber_notification.id,
                     shop_id: @shop.id)
    assert service.valid?
    refute MagazCore::SubscriberNotification.find_by_id(@first_subscriber_notification.id)
    assert MagazCore::SubscriberNotification.find_by_id(@second_subscriber_notification.id)
    assert_equal 1, @shop.subscriber_notifications.count
  end

  test 'should not delete subscriber notification with blank ids' do
    assert_equal 2, @shop.subscriber_notifications.count
    service = MagazCore::AdminServices::SubscriberNotification::DeleteSubscriberNotification
                .run(id: "", shop_id: "")
    refute service.valid?
    assert_equal 2, service.errors.full_messages.count
    assert_equal "Id is not a valid integer", service.errors.full_messages.first
    assert_equal "Shop is not a valid integer", service.errors.full_messages.last
    assert_equal 2, @shop.subscriber_notifications.count
  end
end