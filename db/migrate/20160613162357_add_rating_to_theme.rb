class AddRatingToTheme < ActiveRecord::Migration[4.2][5.0]
  def change
    add_column :themes, :rating, :float
  end
end
