# This migration comes from magaz_core (originally 20130817124105)
class AddShopIdToProduct < ActiveRecord::Migration
  def change
    add_column :products, :shop_id, :integer
  end
end
