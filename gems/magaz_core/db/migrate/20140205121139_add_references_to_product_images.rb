class AddReferencesToProductImages < ActiveRecord::Migration
  def change
    change_table :product_images do |t|
      t.references :product
    end
  end
end
