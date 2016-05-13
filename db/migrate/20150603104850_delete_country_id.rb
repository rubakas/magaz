class DeleteCountryId < ActiveRecord::Migration
  def change
    remove_column :shipping_countries, :country_id
  end
end
