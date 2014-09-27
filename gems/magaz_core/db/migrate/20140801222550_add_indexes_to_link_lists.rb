class AddIndexesToLinkLists < ActiveRecord::Migration
  def change
    add_column :link_lists, :slug, :string
    add_index  :link_lists, :slug, unique: true
  end
end
