class CreateThemeStyles < ActiveRecord::Migration[4.2]
  def change
    create_table :theme_styles do |t|
      t.string :name
      t.string :image
      t.references :theme, foreign_key: true

      t.timestamps
    end
  end
end
