class CreateReviews < ActiveRecord::Migration[4.2]
  def change
    create_table :reviews do |t|
      t.text :body
      t.integer :mark
      t.references :user, foreign_key: true
      t.references :theme, foreign_key: true

      t.timestamps
    end
  end
end
