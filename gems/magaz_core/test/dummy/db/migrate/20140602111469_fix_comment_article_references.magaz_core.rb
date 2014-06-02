# This migration comes from magaz_core (originally 20131217022948)
class FixCommentArticleReferences < ActiveRecord::Migration
  def change
    change_table :comments do |t|
      t.remove :articles_id
      t.references :article
    end
  end
end
