class RenamaTableTaxesOverridesToTaxOverrides < ActiveRecord::Migration[4.2]
  def change
    rename_table :taxes_overrides, :tax_overrides
  end
end
