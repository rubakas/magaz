class AddToSettingsCheckoutsLanguage < ActiveRecord::Migration
  def change
    add_column :shops, :checkout_language, :string
  end
end
