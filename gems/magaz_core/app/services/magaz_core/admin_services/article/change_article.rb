class MagazCore::AdminServices::Article::ChangeArticle < ActiveInteraction::Base

  string  :id, :title, :content, :page_title, :handle, :meta_description
  integer :blog_id

  validates :id, :blog_id, :title, presence: true

  validate :title_uniqueness, if: :title_changed?
  validate :handle_uniqueness, if: :handle_changed?

  def to_model
    MagazCore::Blog.find(blog_id).articles.friendly.find(id)
  end

  def execute
    article = MagazCore::Blog.find(blog_id).articles.friendly.find(id)
    article.update_attributes!(inputs.slice!(:id)) ||
      errors.add(:base, I18n.t('services.change_article.wrong_params'))

    article
  end

  private

  def title_changed?
    MagazCore::Blog.friendly.find(blog_id).articles.friendly.find(id).title != title
  end

  def title_uniqueness
    errors.add(:base, I18n.t('services.change_article.title_not_unique')) unless title_unique?
  end

  def title_unique?
    MagazCore::Article.where(blog_id: blog_id, title: title).count == 0
  end

  def handle_changed?
    MagazCore::Blog.friendly.find(blog_id).articles.friendly.find(id).handle != handle
  end

  def handle_uniqueness
    unless handle.empty?
      errors.add(:base, I18n.t('services.change_article.handle_not_unique')) unless handle_unique?
    end
  end

  def handle_unique?
    MagazCore::Article.where(blog_id: blog_id, handle: handle).count == 0
  end

end