# This migration comes from magaz_core (originally 20140205115646)
class RemoveProductsPicturesTable < ActiveRecord::Migration
  def change
    drop_table :products_pictures
  end
end
