class Shop < ActiveRecord::Base
  has_secure_password validations: false
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :name, presence: true
end
