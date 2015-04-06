module MagazStoreAdmin
require 'test_helper'

class Admin::SubscriberNotificationsControllerTest < ActionController::TestCase
  setup do
    @shop = create(:shop, subdomain: 'example')
    @user = create(:user, shop: @shop)
    session_for_user @user
    @subscriber_notification = create(:subscriber_notification, shop: @shop)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create subscriber_notification' do
    assert_difference('MagazCore::SubscriberNotification.count') do
      post :create, subscriber_notification: { notification_method: 'email', subscription_address: 'some1@here.run' }
    end
    assert_redirected_to notifications_settings_settings_path
  end

  test 'should destroy subscriber_notification' do
    assert_difference('MagazCore::SubscriberNotification.count', -1) do
      delete :destroy, id: @subscriber_notification
    end
    assert_redirected_to notifications_settings_settings_path
  end
end
end
