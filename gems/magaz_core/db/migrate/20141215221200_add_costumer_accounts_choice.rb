class AddCostumerAccountsChoice < ActiveRecord::Migration
  def change
    add_column :shops, :account_type_choice, :string
  end
end
