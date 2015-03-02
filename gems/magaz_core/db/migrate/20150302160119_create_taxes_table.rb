class CreateTaxesTable < ActiveRecord::Migration
  def change
    create_table :taxes do |t|
      t.float :base_taxe

      t.references :shipping_country
    end
  end
end
