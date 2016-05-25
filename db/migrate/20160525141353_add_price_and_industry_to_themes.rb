class AddPriceAndIndustryToThemes < ActiveRecord::Migration[5.0]
  def change
    add_column :themes, :price, :decimal
    add_column :themes, :industry, :string
    add_column :themes, :partner_id, :integer
  end
end
