class DeleteCountryId < ActiveRecord::Migration[4.2]
  def change
    remove_column :shipping_countries, :country_id
  end
end
