# This migration comes from magaz_core (originally 20140324233339)
class AddIndexesToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :slug, :string
    add_index  :articles, :slug, unique: true
  end
end
