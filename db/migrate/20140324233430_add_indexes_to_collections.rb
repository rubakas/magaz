class AddIndexesToCollections < ActiveRecord::Migration[4.2]
  def change
    add_column :collections, :slug, :string
    add_index  :collections, :slug, unique: true
  end
end
