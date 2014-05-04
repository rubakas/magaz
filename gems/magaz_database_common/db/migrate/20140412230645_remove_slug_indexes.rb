class RemoveSlugIndexes < ActiveRecord::Migration
  def change
    remove_index :pages,       :slug
    remove_index :blogs,       :slug
    remove_index :articles,    :slug
    remove_index :collections, :slug
  end
end
