class RenamePaymentsAuthorizationSettings < ActiveRecord::Migration[4.2]
  def change
    rename_column :shops, :authoriz_settings, :authorization_settings
  end
end
