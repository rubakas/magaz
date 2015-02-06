class AddColumnAccountOwnerToUser < ActiveRecord::Migration
  def change
    add_column :users, :account_owner, :boolean, default: false
  end
end
