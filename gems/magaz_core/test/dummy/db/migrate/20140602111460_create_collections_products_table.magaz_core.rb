# This migration comes from magaz_core (originally 20130826143517)
class CreateCollectionsProductsTable < ActiveRecord::Migration
  def change
    create_table :collections_products do |t|
      t.references :collection
      t.references :product
    end
  end
end
