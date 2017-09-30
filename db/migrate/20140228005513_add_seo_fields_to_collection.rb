class AddSeoFieldsToCollection < ActiveRecord::Migration[4.2]
  def change
    add_column :collections, :handle, :string
    add_column :collections, :page_title, :string
    add_column :collections, :meta_description, :string
  end
end
