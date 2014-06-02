# This migration comes from magaz_core (originally 20140204172441)
class RenamePicturesToProductImages < ActiveRecord::Migration
  def change
    rename_table :pictures, :product_images
  end
end
