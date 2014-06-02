# This migration comes from magaz_core (originally 20140416115243)
class AddRoleToThemes < ActiveRecord::Migration
  def change
    add_column :themes, :role, :string
  end
end
