class AddReferencesAndTimestampsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :shop_id, :integer, references: :shops
    change_table(:events) { |t| t.timestamps }
  end
end
