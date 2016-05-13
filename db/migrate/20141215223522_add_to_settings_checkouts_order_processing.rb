class AddToSettingsCheckoutsOrderProcessing < ActiveRecord::Migration
  def change
    add_column :shops, :bulling_adress_is_shipping_too, :boolean
    add_column :shops, :abandoned_checkout_time_delay, :string
    add_column :shops, :email_marketing_choice, :string
    add_column :shops, :after_order_paid, :string
    add_column :shops, :after_order_fulfilled_and_paid, :boolean
  end
end
