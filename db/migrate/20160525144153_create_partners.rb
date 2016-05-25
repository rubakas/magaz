class CreatePartners < ActiveRecord::Migration[5.0]
  def change
    create_table :partners do |t|
      t.string :name

      t.timestamps
    end
    add_index :partners, :name, unique: true
  end
end
