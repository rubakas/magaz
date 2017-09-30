class CreateCollectionsProductsTable < ActiveRecord::Migration[4.2]
  def change
    create_table :collections_products do |t|
      t.references :collection
      t.references :product
    end
  end
end
