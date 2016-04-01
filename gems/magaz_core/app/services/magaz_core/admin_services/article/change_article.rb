class MagazCore::AdminServices::Article::ChangeArticle < ActiveInteraction::Base

  string :title, :content, :page_title, :handle, :meta_description
  integer :id, :blog_id

  validates :id, :blog_id, :title, presence: true

  validate :title_uniqueness, if: :title_changed?

  def execute
    article = MagazCore::Article.friendly.find(id)
    article.update_attributes!(inputs.slice!(:id)) ||
      errors.add(:base, I18n.t('default.services.change_article.wrong_params'))

    article
  end

  private

  def title_changed?
    MagazCore::Blog.friendly.find(blog_id).articles.friendly.find(id).title != title
  end

  def title_uniqueness
    errors.add(:base, I18n.t('default.services.change_article.title_not_unique')) unless title_unique?
  end

  def title_unique?
    MagazCore::Article.where(blog_id: blog_id, title: title).count == 0
  end

end