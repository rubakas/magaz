class RenamaTableTaxesOverridesToTaxOverrides < ActiveRecord::Migration
  def change
    rename_table :taxes_overrides, :tax_overrides
  end
end
