class AddSeoFieldsToPagesBlogsArticles < ActiveRecord::Migration[4.2]
  def change
    add_column :pages, :handle, :string
    add_column :pages, :page_title, :string
    add_column :pages, :meta_description, :string

    add_column :blogs, :handle, :string
    add_column :blogs, :page_title, :string
    add_column :blogs, :meta_description, :string

    add_column :articles, :handle, :string
    add_column :articles, :page_title, :string
    add_column :articles, :meta_description, :string
  end
end
