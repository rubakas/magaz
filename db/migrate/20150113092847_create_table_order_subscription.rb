class CreateTableOrderSubscription < ActiveRecord::Migration
  def change
    create_table :order_subscriptions do |t|
      t.string :notification_method
      t.string :subscription_address
      
      t.references :shop
      t.timestamps
    end
  end
end
