class FixCommentArticleReferences < ActiveRecord::Migration
  def change
    change_table :comments do |t|
      t.remove :articles_id
      t.references :article
    end
  end
end
