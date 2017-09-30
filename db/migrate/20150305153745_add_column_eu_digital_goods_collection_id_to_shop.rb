class AddColumnEuDigitalGoodsCollectionIdToShop < ActiveRecord::Migration[4.2]
  def change
    add_column :shops, :eu_digital_goods_collection_id, :integer
  end
end
