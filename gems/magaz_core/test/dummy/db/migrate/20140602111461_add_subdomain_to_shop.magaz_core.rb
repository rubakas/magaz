# This migration comes from magaz_core (originally 20130910113625)
class AddSubdomainToShop < ActiveRecord::Migration
  def change
    add_column :shops, :subdomain, :string
  end
end
