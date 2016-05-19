class AddFieldsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :product_type, :string
    add_column :products, :sku, :string
    add_column :products, :price, :decimal, precision: 38, scale: 2
  end
end
