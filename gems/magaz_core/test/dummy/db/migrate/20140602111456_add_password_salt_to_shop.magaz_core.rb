# This migration comes from magaz_core (originally 20130730203558)
class AddPasswordSaltToShop < ActiveRecord::Migration
  def change
    add_column :shops, :password_salt, :string
  end
end
