class Shop < ActiveRecord::Base
  has_secure_password validations: false
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
  validates :password, presence: true
  validates :name, presence: true
end
