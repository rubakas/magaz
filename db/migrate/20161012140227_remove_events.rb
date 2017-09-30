class RemoveEvents < ActiveRecord::Migration[4.2][5.0]
  def change
    drop_table :events
  end
end
