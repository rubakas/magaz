# This migration comes from magaz_core (originally 20140324233327)
class AddIndexesToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :slug, :string
    add_index  :blogs, :slug, unique: true
  end
end
