class CreateProductsPicturesTable < ActiveRecord::Migration[4.2]
  def change
    create_table :products_pictures do |t|
      t.references :product
      t.references :picture
    end
  end
end
