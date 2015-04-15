class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string  :arguments, :array => true, :default => []
      t.string  :body
      t.text    :description
      t.string  :path
      t.string  :message
      t.integer :subject_id
      t.string  :subject_type
      t.string  :verb
    end
  end
end
