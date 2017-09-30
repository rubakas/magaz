class CreateLineItems < ActiveRecord::Migration[4.2]
  def change
    create_table :line_items do |t|
      t.references :order
      t.references :product
      t.string :name
      t.text :description
      t.decimal :price, precision: 38, scale: 2
      t.integer :quantity

      t.timestamps
    end
  end
end
