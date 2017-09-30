class AddColumnsFromTaxesToShop < ActiveRecord::Migration[4.2]
  def change
    add_column :shops, :all_taxes_are_included, :boolean
    add_column :shops, :charge_taxes_on_shipping_rates, :boolean
  end
end
