class CreateCollections < ActiveRecord::Migration[4.2]
  def change
    create_table :collections do |t|
      t.string :name
      t.text :description
      t.references :shop

      t.timestamps
    end
  end
end
