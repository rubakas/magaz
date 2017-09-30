class RemoveProductsPicturesTable < ActiveRecord::Migration[4.2]
  def change
    drop_table :products_pictures
  end
end
