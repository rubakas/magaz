class AddNewColumnsToThemes < ActiveRecord::Migration[4.2][5.0]
  def change
    add_column :themes, :price, :decimal
    add_column :themes, :industry, :string
    add_reference :themes, :partner, foreign_key: true
  end
end
