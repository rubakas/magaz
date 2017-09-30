class CreateOrders < ActiveRecord::Migration[4.2]
  def change
    create_table :orders do |t|
      t.references :shop
      t.text :note
      t.string :status
      t.string :financial_status
      t.string :fulfillment_status
      t.string :currency
      t.string :email

      t.timestamps
    end
  end
end
