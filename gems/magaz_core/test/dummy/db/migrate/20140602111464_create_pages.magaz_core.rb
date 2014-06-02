# This migration comes from magaz_core (originally 20131107193139)
class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.string :description
      t.references :shop

      t.timestamps
    end
  end
end
