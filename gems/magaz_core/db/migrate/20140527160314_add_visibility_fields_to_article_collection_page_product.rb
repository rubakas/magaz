class AddVisibilityFieldsToArticleCollectionPageProduct < ActiveRecord::Migration
  def change
    [:articles, :collections, :pages, :products].each do |table_name|
      add_column table_name, :publish_on, :datetime
      add_column table_name, :published_at, :datetime
    end
  end
end
