class Customer < ActiveRecord::Base
  has_many :checkouts
  belongs_to :shop

  validates :email, presence: true
end