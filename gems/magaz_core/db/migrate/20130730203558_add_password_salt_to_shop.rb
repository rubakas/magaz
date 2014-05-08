class AddPasswordSaltToShop < ActiveRecord::Migration
  def change
    add_column :shops, :password_salt, :string
  end
end
