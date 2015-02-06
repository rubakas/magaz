class RemoveColumnsEmailPasswordFromShop < ActiveRecord::Migration
  def change
    remove_column :shops, :password_digest
    remove_column :shops, :email
  end
end
