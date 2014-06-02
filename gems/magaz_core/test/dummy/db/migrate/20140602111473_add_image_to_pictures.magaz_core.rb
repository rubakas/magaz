# This migration comes from magaz_core (originally 20140121145602)
class AddImageToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :image, :string
  end
end
