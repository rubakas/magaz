# This migration comes from magaz_core (originally 20140121151109)
class CreateProductsPicturesTable < ActiveRecord::Migration
  def change
    create_table :products_pictures do |t|
      t.references :product
      t.references :picture
    end
  end
end
