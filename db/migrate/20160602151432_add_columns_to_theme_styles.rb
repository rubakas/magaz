class AddColumnsToThemeStyles < ActiveRecord::Migration[5.0]
  def change
    add_column :theme_styles, :industry, :string
    add_column :theme_styles, :example_site_url, :string
  end
end
