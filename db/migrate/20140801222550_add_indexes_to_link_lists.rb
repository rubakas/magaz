class AddIndexesToLinkLists < ActiveRecord::Migration[4.2]
  def change
    add_column :link_lists, :slug, :string
    add_index  :link_lists, :slug, unique: true
  end
end
