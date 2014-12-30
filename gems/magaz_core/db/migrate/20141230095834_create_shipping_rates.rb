class CreateShippingRates < ActiveRecord::Migration
  def change
    create_table :shipping_rates do |t|
      t.string :name
      t.string :criteria
      t.string :price_from
      t.string :price_to
      t.string :weight_from
      t.string :weight_to
      t.string :shipping_price

      t.references :country
      t.timestamps
    end
  end
end
