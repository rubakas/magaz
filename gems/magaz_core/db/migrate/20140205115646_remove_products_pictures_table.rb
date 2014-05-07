class RemoveProductsPicturesTable < ActiveRecord::Migration
  def change
    drop_table :products_pictures
  end
end
