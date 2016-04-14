class MagazCore::AdminServices::Article::AddArticle < ActiveInteraction::Base

  string :title, :content, :page_title, :handle, :meta_description
  integer :blog_id

  validates :title, :blog_id, presence: true

  validate :title_uniqueness

  def to_model
    MagazCore::Article.new
  end

  def execute
    article = MagazCore::Article.new(inputs)

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

end