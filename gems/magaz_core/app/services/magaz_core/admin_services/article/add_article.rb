class MagazCore::AdminServices::Article::AddArticle < ActiveInteraction::Base

  string :title, :content, :page_title, :handle, :meta_description
  integer :blog_id

  validates :title, :blog_id, presence: true

  validate :title_uniqueness, :handle_uniqueness

  def to_model
    MagazCore::Article.new
  end

  def execute
    article = MagazCore::Blog.find(blog_id).articles.new(inputs)

    unless article.save
      errors.merge!(article.errors)
    end

    article
  end

  private

  def title_uniqueness
    errors.add(:base, I18n.t('services.add_article.title_not_unique')) unless title_unique?
  end

  def title_unique?
    MagazCore::Article.where(blog_id: blog_id, title: title).count == 0
  end

  def handle_uniqueness
    unless handle.empty?
      errors.add(:base, I18n.t('services.add_article.handle_not_unique')) unless handle_unique?
    end
  end

  def handle_unique?
    MagazCore::Article.where(blog_id: blog_id, handle: handle).count == 0
  end

end