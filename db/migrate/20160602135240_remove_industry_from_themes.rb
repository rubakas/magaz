class RemoveIndustryFromThemes < ActiveRecord::Migration[5.0]
  def change
    remove_column :themes, :industry
  end
end
