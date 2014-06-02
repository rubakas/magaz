# This migration comes from magaz_core (originally 20140324233312)
class AddIndexesToPages < ActiveRecord::Migration
  def change
    add_column :pages, :slug, :string
    add_index  :pages, :slug, unique: true
  end
end
