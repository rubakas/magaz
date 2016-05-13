class CreateTableTaxesOverrides < ActiveRecord::Migration
  def change
    create_table :taxes_overrides do |t|
      t.float :rate
      t.boolean :is_shipping, default: false

      t.references :collection
      t.references :shipping_country
    end
  end
end
