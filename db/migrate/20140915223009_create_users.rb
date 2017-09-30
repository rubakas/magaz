class CreateUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :phone
      t.string :homepage
      t.string :bio

      t.references :shop
      t.timestamps
    end
  end
end
