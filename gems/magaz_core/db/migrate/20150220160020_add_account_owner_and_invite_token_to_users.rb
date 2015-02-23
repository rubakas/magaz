class AddAccountOwnerAndInviteTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :account_owner, :boolean, default: false
    add_column :users, :invite_token, :string
  end
end
