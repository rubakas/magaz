class CreateShops < ActiveRecord::Migration[4.2]
  def change
    create_table :shops do |t|
      t.string :email
      t.string :name
      t.string :password_digest

      t.timestamps
    end
  end
end
