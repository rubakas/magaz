# This migration comes from magaz_core (originally 20140415133234)
class CreateThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.string :name

      t.timestamps
    end
  end
end
