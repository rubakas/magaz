class AddSubdomainToShop < ActiveRecord::Migration
  def change
    add_column :shops, :subdomain, :string
  end
end
