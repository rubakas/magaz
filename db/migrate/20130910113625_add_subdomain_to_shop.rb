class AddSubdomainToShop < ActiveRecord::Migration[4.2]
  def change
    add_column :shops, :subdomain, :string
  end
end
