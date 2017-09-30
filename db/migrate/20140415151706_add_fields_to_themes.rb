class AddFieldsToThemes < ActiveRecord::Migration[4.2]
  def change
    add_column :themes, :shop_id, :integer
    add_column :themes, :source_theme_id, :integer
  end
end
