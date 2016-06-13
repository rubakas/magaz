class AddRatingToTheme < ActiveRecord::Migration[5.0]
  def change
    add_column :themes, :rating, :float
  end
end
