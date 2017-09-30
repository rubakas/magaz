class AddShopIdToProduct < ActiveRecord::Migration[4.2]
  def change
    add_column :products, :shop_id, :integer
  end
end
