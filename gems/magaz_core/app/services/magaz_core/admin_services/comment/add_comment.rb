class MagazCore::AdminServices::Comment::AddComment < ActiveInteraction::Base

  set_callback :validate, :after, -> {comment}

  string :author, :email, :body
  integer :article_id, :blog_id

  validates :author, :body, :email, :article_id, :blog_id, presence: true

  validate :check_email, :blog_has_article

  def comment
    @comment = MagazCore::Article.friendly.find(article_id).comments.new
    add_errors if errors.any?
    @comment
  end

  def execute
    unless @comment.update_attributes(inputs)
      errors.merge!(@comment.errors)
    end

    @comment
  end

  private

  def check_email
    errors.add(:base, I18n.t('services.add_comment.email_not_valid')) unless email_valid?
  end

  def email_valid?
    email && email =~ MagazCore::Concerns::PasswordAuthenticable::EMAIL_VALID_REGEX
  end

  def add_errors
    errors.full_messages.each do |msg|
      @comment.errors.add(:base, msg)
    end
  end

  def blog_has_article
    errors
    .add(:base,
         I18n.t('services.add_comment.article_not_belongs')) unless MagazCore::Article.find(article_id).blog_id == blog_id
  end
end
