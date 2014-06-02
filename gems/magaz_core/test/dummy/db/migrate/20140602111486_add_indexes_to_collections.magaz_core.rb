# This migration comes from magaz_core (originally 20140324233430)
class AddIndexesToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :slug, :string
    add_index  :collections, :slug, unique: true
  end
end
