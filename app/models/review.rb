class Review < ApplicationRecord
  belongs_to :user
  belongs_to :theme
  validates :user_id, :theme_id, :mark, :body, presence: true
  validates :theme_id, uniqueness: { scope: :user_id }
  validates :body, length: { minimum: 30, maximum: 400 }
end
