class MagazCore::ShopServices::Comment::AddComment < ActiveInteraction::Base

  string :author, :email, :body
  integer :article_id, :blog_id

  validates :author, :body, :email, :article_id, :blog_id, presence: true

  validate :blog_has_article

  def to_model
    MagazCore::Comment.new
  end

  def execute
    comment = MagazCore::Comment.new(inputs)

    unless comment.save
      errors.merge!(comment.errors)
    end

    comment
  end

  private

  def blog_has_article
    errors.add(:base, I18n.t('default.services.add_comment.article_not_belongs')) unless MagazCore::Article.find(article_id).blog_id == blog_id
  end
end
