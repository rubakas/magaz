class AddSeoFieldsToProducts < ActiveRecord::Migration[4.2]
  def change
    add_column :products, :handle, :string
    add_column :products, :page_title, :string
    add_column :products, :meta_description, :string
  end
end
