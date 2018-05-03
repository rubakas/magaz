class CreatePartners < ActiveRecord::Migration[4.2]
  def change
    create_table :partners do |t|
      t.string :name
      t.string :website_url

      t.timestamps
    end
    add_index :partners, :name, unique: true
    add_index :partners, :website_url, unique: true
  end
end
