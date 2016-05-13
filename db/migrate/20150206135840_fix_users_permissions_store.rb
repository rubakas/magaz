class FixUsersPermissionsStore < ActiveRecord::Migration
  def change
    remove_column :users, :permissions
    add_column :users, :permissions, :string, :array => true, :default => []
  end
end
