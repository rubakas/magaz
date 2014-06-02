# This migration comes from magaz_core (originally 20131109231213)
class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.references :shop

      t.timestamps
    end
  end
end
