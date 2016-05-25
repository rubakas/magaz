class CreateThemeStyles < ActiveRecord::Migration[5.0]
  def change
    create_table :theme_styles do |t|
      t.string :name
      t.string :image
      t.references :theme

      t.timestamps
    end
  end
end
