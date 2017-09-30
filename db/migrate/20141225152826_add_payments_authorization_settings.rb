class AddPaymentsAuthorizationSettings < ActiveRecord::Migration[4.2]
  def change
    add_column :shops, :authoriz_settings, :string
  end
end
