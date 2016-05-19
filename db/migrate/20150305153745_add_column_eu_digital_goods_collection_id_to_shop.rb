class AddColumnEuDigitalGoodsCollectionIdToShop < ActiveRecord::Migration
  def change
    add_column :shops, :eu_digital_goods_collection_id, :integer
  end
end
