class Comment < ActiveRecord::Base
  belongs_to :blog
  belongs_to :article

  validates :author, presence: true, uniqueness: { scope: :article_id }
  validates :email, presence: true
  validates :body, presence: true
end
