module MagazCore
  class User < ActiveRecord::Base
    include Concerns::PasswordAuthenticable

    self.table_name = 'users'

    belongs_to :shop

    validates :email, presence: true, uniqueness: { scope: :shop_id }
    validates :first_name, presence: true
    validates :last_name, presence: true
  end
end
