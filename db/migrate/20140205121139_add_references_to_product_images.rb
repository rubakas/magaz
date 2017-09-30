class AddReferencesToProductImages < ActiveRecord::Migration[4.2]
  def change
    change_table :product_images do |t|
      t.references :product
    end
  end
end
