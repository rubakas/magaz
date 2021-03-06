class RenameOrdersToCheckouts < ActiveRecord::Migration[4.2]
  def change
    rename_table :orders, :checkouts

    change_table :line_items do |t|
      t.rename :order_id, :checkout_id
    end
  end
end
