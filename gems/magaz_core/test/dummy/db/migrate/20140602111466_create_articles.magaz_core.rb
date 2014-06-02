# This migration comes from magaz_core (originally 20131110003619)
class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.references :blog

      t.timestamps
    end
  end
end
