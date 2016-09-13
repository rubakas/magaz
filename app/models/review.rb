class Review < ApplicationRecord
  # associations
  belongs_to :user
  belongs_to :theme

  #validations
  validates :body, presence: true, length: { minimum: 30, maximum: 400 }
  validates :mark, presence: true
  validates :theme_id, uniqueness: { scope: :user_id }, presence: true
  validates :user_id, presence: true

end
