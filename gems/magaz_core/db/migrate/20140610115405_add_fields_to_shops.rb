class AddFieldsToShops < ActiveRecord::Migration
  def change
    add_column :shops, :address,        :string
    add_column :shops, :business_name,  :string
    add_column :shops, :city,           :string
    add_column :shops, :country,        :string
    add_column :shops, :currency,       :string
    add_column :shops, :customer_email, :string
    add_column :shops, :phone,          :string
    add_column :shops, :province,       :string
    add_column :shops, :timezone,       :string
    add_column :shops, :unit_system,    :string
    add_column :shops, :zip,            :integer
    #seo_fields
    add_column :shops, :handle,           :string
    add_column :shops, :page_title,       :string
    add_column :shops, :meta_description, :string
  end
end
