class CreateWebhooksTable < ActiveRecord::Migration[4.2]
  def change
    create_table :webhooks do |t|
      t.string :address
      t.string :fields, :array => true, :default => []
      t.string :format
      t.string :metafield_namespaces, :array => true, :default => []
      t.string :topic

      t.references :shop
      t.timestamps
    end
  end
end
