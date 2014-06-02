# This migration comes from magaz_core (originally 20131101032033)
class RemoveFieldsFromProducts < ActiveRecord::Migration
  def up
    remove_column :products, :sku
    remove_column :products, :product_type
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
