class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string     :code
      t.string     :name
      t.float      :tax

      t.references :shop
      t.timestamps
    end
  end
end
