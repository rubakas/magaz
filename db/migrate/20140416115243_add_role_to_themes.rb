class AddRoleToThemes < ActiveRecord::Migration
  def change
    add_column :themes, :role, :string
  end
end
