class CreateThemes < ActiveRecord::Migration[4.2]
  def change
    create_table :themes do |t|
      t.string :name

      t.timestamps
    end
  end
end
