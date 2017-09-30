class AddImageToPictures < ActiveRecord::Migration[4.2]
  def change
    add_column :pictures, :image, :string
  end
end
