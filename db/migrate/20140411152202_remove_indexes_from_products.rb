class RemoveIndexesFromProducts < ActiveRecord::Migration[4.2]
  def change
    remove_index :products, :slug
  end
end
