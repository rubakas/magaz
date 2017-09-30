class FixCommentArticleReferences < ActiveRecord::Migration[4.2]
  def change
    change_table :comments do |t|
      t.remove :articles_id
      t.references :article
    end
  end
end
