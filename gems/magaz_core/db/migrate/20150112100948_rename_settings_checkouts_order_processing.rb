class RenameSettingsCheckoutsOrderProcessing < ActiveRecord::Migration
  def change
    rename_column :shops, :bulling_adress_is_shipping_too, :billing_address_is_shipping_too
  end
end
