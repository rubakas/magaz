class RenamePicturesToProductImages < ActiveRecord::Migration[4.2]
  def change
    rename_table :pictures, :product_images
  end
end
