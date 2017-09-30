class AddCostumerAccountsChoice < ActiveRecord::Migration[4.2]
  def change
    add_column :shops, :account_type_choice, :string
  end
end
