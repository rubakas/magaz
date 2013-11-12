class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :author
      t.text :body
      t.string :email
      t.references :blog
      t.references :articles

      t.timestamps
    end
  end
end
