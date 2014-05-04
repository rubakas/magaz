class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.integer :theme_id
      t.string :content_type
      t.string :key
      t.string :public_url
      t.integer :size
      t.string :src
      t.string :value

      t.timestamps
    end
  end
end
