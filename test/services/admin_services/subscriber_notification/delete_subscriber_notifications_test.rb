require 'test_helper'

class AdminServices::SubscriberNotification::DeleteSubscriberNotificationTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @first_subscriber_notification = create(:subscriber_notification, shop: @shop)
    @second_subscriber_notification = create(:subscriber_notification, shop: @shop)
  end

  test 'should delete subscriber notification with valid ids' do
    assert_equal 2, @shop.subscriber_notifications.count
    service = AdminServices::SubscriberNotification::DeleteSubscriberNotification
              .new(id: @first_subscriber_notification.id,
                   shop_id: @shop.id)
              .run
    assert service.success?
    refute SubscriberNotification.find_by_id(@first_subscriber_notification.id)
    assert SubscriberNotification.find_by_id(@second_subscriber_notification.id)
    assert_equal 1, @shop.subscriber_notifications.count
  end

  test 'should rise exeption with blank ids' do
    assert_equal 2, @shop.subscriber_notifications.count
    assert_raises ActiveRecord::RecordNotFound do
      AdminServices::SubscriberNotification::DeleteSubscriberNotification.new.run
    end
  end
end
