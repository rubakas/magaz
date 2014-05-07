class AddCustomerToCheckouts < ActiveRecord::Migration
  def up
    remove_column :checkouts, :shop_id
    add_column :checkouts, :customer_id, :integer
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
