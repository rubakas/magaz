class AdminServices::Article::ChangeArticle < ActiveInteraction::Base

  set_callback :validate, :after, -> {article}

  string  :id, :title, :content, :page_title, :handle, :meta_description
  integer :blog_id

  validates :id, :blog_id, :title, presence: true
  validate :title_uniqueness, if: :title_changed?
  validate :handle_uniqueness, if: :handle_changed?

  def article
    @article = Article.friendly.find(id)
    add_errors if errors.any?
    @article
  end

  def execute
    @article.update_attributes!(inputs.slice!(:id)) ||
      errors.add(:base, I18n.t('services.change_article.wrong_params'))
    @article
  end

  private

  def add_errors
    errors.full_messages.each do |msg|
      @article.errors.add(:base, msg)
    end
  end

  def title_changed?
    ::Article.friendly.find(id).blog_id != blog_id ||
                                      ::Article.friendly.find(id).title != title
  end

  def title_uniqueness
    errors.add(:base, I18n.t('services.change_article.title_not_unique')) unless title_unique?
  end

  def title_unique?
    ::Article.where.not(id: id).where(blog_id: blog_id, title: title).count == 0
  end

  def handle_changed?
    ::Article.friendly.find(id).blog_id != blog_id ||
                                    ::Article.friendly.find(id).handle != handle
  end

  def handle_uniqueness
    unless handle.empty?
      errors.add(:base, I18n.t('services.change_article.handle_not_unique')) unless handle_unique?
    end
  end

  def handle_unique?
    ::Article.where.not(id: id).where(blog_id: blog_id, handle: handle).count == 0
  end

end
