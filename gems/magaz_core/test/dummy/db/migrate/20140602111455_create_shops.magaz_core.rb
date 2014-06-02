# This migration comes from magaz_core (originally 20130718032357)
class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :email
      t.string :name
      t.string :password_digest

      t.timestamps
    end
  end
end
