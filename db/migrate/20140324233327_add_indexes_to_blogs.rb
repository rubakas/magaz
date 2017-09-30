class AddIndexesToBlogs < ActiveRecord::Migration[4.2]
  def change
    add_column :blogs, :slug, :string
    add_index  :blogs, :slug, unique: true
  end
end
