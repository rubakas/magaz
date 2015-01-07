class ChangesInShippingRates < ActiveRecord::Migration
  def change
    change_table :shipping_rates do |t|
      t.change :price_from,     :float
      t.change :price_to,       :float
      t.change :weight_from,    :float
      t.change :weight_to,      :float
      t.change :shipping_price, :float
    end
  end
end
