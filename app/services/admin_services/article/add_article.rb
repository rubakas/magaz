class AdminServices::Article::AddArticle < ActiveInteraction::Base

  set_callback :validate, :after, -> {article}

  string :title, :content, :page_title, :handle, :meta_description
  integer :blog_id

  validates :title, :blog_id, presence: true
  validate :title_uniqueness, :handle_uniqueness

  def article
    @article = Article.new
    add_errors if errors.any?
    @article
  end

  def execute
    unless @article.update_attributes(inputs)
      errors.merge!(@article.errors)
    end
    @article
  end

  private

  def add_errors
    errors.full_messages.each do |msg|
      @article.errors.add(:base, msg)
    end
  end

  def title_uniqueness
    errors.add(:base, I18n.t('services.add_article.title_not_unique')) unless title_unique?
  end

  def title_unique?
    ::Article.where(blog_id: blog_id, title: title).count == 0
  end

  def handle_uniqueness
    unless handle.empty?
      errors.add(:base, I18n.t('services.add_article.handle_not_unique')) unless handle_unique?
    end
  end

  def handle_unique?
    ::Article.where(blog_id: blog_id, handle: handle).count == 0
  end

end
