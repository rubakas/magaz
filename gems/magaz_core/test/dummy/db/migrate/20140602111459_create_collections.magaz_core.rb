# This migration comes from magaz_core (originally 20130826114821)
class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :name
      t.text :description
      t.references :shop

      t.timestamps
    end
  end
end
