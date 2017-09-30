class AddToSettingsCheckoutsLanguage < ActiveRecord::Migration[4.2]
  def change
    add_column :shops, :checkout_language, :string
  end
end
