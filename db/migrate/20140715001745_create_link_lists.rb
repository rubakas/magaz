class CreateLinkLists < ActiveRecord::Migration
  def change
    create_table :link_lists do |t|
      t.string     :name
      t.references :shop
      t.string     :handle
    end
  end
end
