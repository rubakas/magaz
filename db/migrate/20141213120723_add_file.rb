class AddFile < ActiveRecord::Migration[4.2]
  def change
    add_column :files, :file_size, :integer
  end
end
