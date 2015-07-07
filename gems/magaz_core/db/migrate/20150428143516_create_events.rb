class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string  :arguments, :array => true, :default => []
      t.string  :body
      t.string  :message
      t.integer :subject_id
      t.string  :subject_type
      t.string  :verb

      t.references :shop
      t.timestamps
    end
    add_index :events, :subject_id
  end
end
