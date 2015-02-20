module MagazCore
  class Invite < ActiveRecord::Base
    self.table_name = 'invites'

    before_create :generate_token

    validates :email, presence: true, uniqueness: { scope: :shop_id }

    belongs_to :shop

    belongs_to :sender, :class_name => 'MagazCore::User'
    belongs_to :recipient, :class_name => 'MagazCore::User'

    def generate_token
       self.token = Digest::SHA1.hexdigest([self.sender_id, Time.now, rand].join)
    end
  end
end
