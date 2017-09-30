class AddRoleToThemes < ActiveRecord::Migration[4.2]
  def change
    add_column :themes, :role, :string
  end
end
