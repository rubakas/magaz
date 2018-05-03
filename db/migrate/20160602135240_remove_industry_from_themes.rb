class RemoveIndustryFromThemes < ActiveRecord::Migration[4.2]
  def change
    remove_column :themes, :industry
  end
end
