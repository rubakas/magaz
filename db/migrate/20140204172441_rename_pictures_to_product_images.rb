class RenamePicturesToProductImages < ActiveRecord::Migration
  def change
    rename_table :pictures, :product_images
  end
end
