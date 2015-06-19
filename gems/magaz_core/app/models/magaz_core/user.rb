module MagazCore
  class User < ActiveRecord::Base
    include Concerns::PasswordAuthenticable
    self.table_name = 'users'

    belongs_to :shop
    has_many :events, as: :subject

    validates :email, presence: true, uniqueness: { scope: :shop_id }
    validates :first_name, presence: true
    validates :last_name, presence: true

    def full_name
      [self.first_name, self.last_name].map(&:capitalize).join(" ")
    end
  end
end
