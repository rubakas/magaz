class RenameSettingsCheckoutsOrderProcessing < ActiveRecord::Migration[4.2]
  def change
    rename_column :shops, :bulling_adress_is_shipping_too, :billing_address_is_shipping_too
  end
end
