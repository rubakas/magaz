class AddPaymentsAcceptPayments < ActiveRecord::Migration
  def change
    add_column :shops, :paypal_methods, :string
    add_column :shops, :additional_methods, :string
    add_column :shops, :custom_methods, :string 
  end
end
