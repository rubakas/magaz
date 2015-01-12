class AddFile < ActiveRecord::Migration
  def change
    add_column :files, :file_size, :integer
  end
end
