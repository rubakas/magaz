class CreateFiles < ActiveRecord::Migration
  def change
    create_table :files do |t|
      t.string     :file
      t.string     :name
      t.references :shop

      t.timestamps
    end
  end
end
