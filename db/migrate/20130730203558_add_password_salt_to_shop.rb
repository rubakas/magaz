class AddPasswordSaltToShop < ActiveRecord::Migration[4.2]
  def change
    add_column :shops, :password_salt, :string
  end
end
