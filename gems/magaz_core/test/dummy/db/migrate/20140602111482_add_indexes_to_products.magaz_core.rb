# This migration comes from magaz_core (originally 20140324105433)
class AddIndexesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :slug, :string
    add_index  :products, :slug, unique: true
  end
end
