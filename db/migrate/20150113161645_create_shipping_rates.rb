class CreateShippingRates < ActiveRecord::Migration[4.2]
  def change
    create_table :shipping_rates do |t|
      t.string :name
      t.string :criteria
      t.float :price_from
      t.float :price_to
      t.float :weight_from
      t.float :weight_to
      t.float :shipping_price

      t.references :shipping_country
      t.timestamps
    end
  end
end
