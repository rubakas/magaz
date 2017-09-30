class RemoveFieldsFromProducts < ActiveRecord::Migration[4.2]
  def up
    remove_column :products, :sku
    remove_column :products, :product_type
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
