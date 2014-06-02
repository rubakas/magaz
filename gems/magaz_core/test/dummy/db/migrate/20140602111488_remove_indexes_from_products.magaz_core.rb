# This migration comes from magaz_core (originally 20140411152202)
class RemoveIndexesFromProducts < ActiveRecord::Migration
  def change
    remove_index :products, :slug
  end
end
