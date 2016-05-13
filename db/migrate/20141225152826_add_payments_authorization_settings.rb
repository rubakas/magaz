class AddPaymentsAuthorizationSettings < ActiveRecord::Migration
  def change
    add_column :shops, :authoriz_settings, :string
  end
end
