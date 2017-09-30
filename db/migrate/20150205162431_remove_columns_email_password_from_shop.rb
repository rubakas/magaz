class RemoveColumnsEmailPasswordFromShop < ActiveRecord::Migration[4.2]
  def change
    remove_column :shops, :password_digest
    remove_column :shops, :email
  end
end
