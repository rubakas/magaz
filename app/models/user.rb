class User < ActiveRecord::Base
  include Concerns::PasswordAuthenticable

  has_many    :events, as: :subject
  has_many    :reviews
  belongs_to  :shop
  validates :shop_id, :email, :first_name, :last_name, presence: true
  validates :email,
            uniqueness: { scope: :shop_id },
            format: { with: Concerns::PasswordAuthenticable::EMAIL_VALID_REGEX }

  def full_name
    [self.first_name, self.last_name].map(&:capitalize).join(" ")
  end
end
