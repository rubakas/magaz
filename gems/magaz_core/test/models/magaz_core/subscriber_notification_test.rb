require 'test_helper'

module MagazCore
  class SubscriberNotificationTest < ActiveSupport::TestCase

    setup do
      @shop = create(:shop, subdomain: 'example')
    end

    should belong_to(:shop)
    should allow_value(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i).for(:subscription_address)

    test 'should not be number if needs email' do
      shipping_country = MagazCore::SubscriberNotification.new(shop: @shop,
                                                               notification_method: "email",
                                                               subscription_address: "333-3333-3333" )
      assert_not shipping_country.valid?
    end


    test 'should not be email if needs number' do
      shipping_country = MagazCore::SubscriberNotification.new(shop: @shop,
                                                               notification_method: "phone",
                                                               subscription_address: "some@email.com" )
      assert_not shipping_country.valid?
    end

    test 'should not be empty' do
      shipping_country = MagazCore::SubscriberNotification.new(shop: @shop,
                                                               notification_method: "phone",
                                                               subscription_address: "" )
      assert_not shipping_country.valid?
    end
  end
end
