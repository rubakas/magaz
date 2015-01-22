class RemoveColumnsWithTextFromSubscriberNotifications < ActiveRecord::Migration
  def change
    remove_column :order_subscriptions, :abandoned_checkout_notification_html
    remove_column :order_subscriptions, :abandoned_checkout_notification_txt 
    remove_column :order_subscriptions, :contact_buyer_html 
    remove_column :order_subscriptions, :contact_buyer_txt 
    remove_column :order_subscriptions, :fulfillment_request_html 
    remove_column :order_subscriptions, :fulfillment_request_txt 
    remove_column :order_subscriptions, :gift_card_notification_html 
    remove_column :order_subscriptions, :gift_card_notification_txt 
    remove_column :order_subscriptions, :new_order_notification_html 
    remove_column :order_subscriptions, :new_order_notification_txt 
    remove_column :order_subscriptions, :new_order_notification_mobile_html 
    remove_column :order_subscriptions, :new_order_notification_mobile_txt 
    remove_column :order_subscriptions, :order_cancelled_html 
    remove_column :order_subscriptions, :order_cancelled_txt 
    remove_column :order_subscriptions, :order_confirmation_html 
    remove_column :order_subscriptions, :order_confirmation_txt 
    remove_column :order_subscriptions, :refund_notification_html 
    remove_column :order_subscriptions, :refund_notification_txt 
    remove_column :order_subscriptions, :shipping_confirmation_html 
    remove_column :order_subscriptions, :shipping_confirmation_txt 
    remove_column :order_subscriptions, :shipping_update_html 
    remove_column :order_subscriptions, :shipping_update_txt
  end
end
