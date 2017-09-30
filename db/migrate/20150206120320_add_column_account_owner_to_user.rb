class AddColumnAccountOwnerToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :account_owner, :boolean, default: false
  end
end
