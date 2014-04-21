class AddSeoFieldsToCollection < ActiveRecord::Migration
  def change
    add_column :collections, :handle, :string
    add_column :collections, :page_title, :string
    add_column :collections, :meta_description, :string
  end
end
