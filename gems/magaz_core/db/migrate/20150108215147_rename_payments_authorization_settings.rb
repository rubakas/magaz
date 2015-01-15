class RenamePaymentsAuthorizationSettings < ActiveRecord::Migration
  def change
    rename_column :shops, :authoriz_settings, :authorization_settings
  end
end
