class RemovePathColumnFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :path
  end
end
