class AddHiddenFieldsToCheckoutsSettings < ActiveRecord::Migration
  def change
    add_column :shops, :enable_multipass_login, :boolean
    add_column :shops, :notify_customers_of_their_shipment, :boolean
    add_column :shops, :automatically_fulfill_all_orders, :boolean
  end
end
