class AddPaymentsAuthorizationSettings < ActiveRecord::Migration
  def change
    add_column :shops, :authoreze_settings, :string
  end
end
