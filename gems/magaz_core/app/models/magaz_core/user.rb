module MagazCore
  class User < ActiveRecord::Base
    include Concerns::PasswordAuthenticable
    self.table_name = 'users'

    belongs_to :shop

    has_many :invitations, :class_name => "MagazCore::Invite", :foreign_key => 'recipient_id', :dependent => :destroy
    has_many :sent_invites, :class_name => "MagazCore::Invite", :foreign_key => 'sender_id', :dependent => :destroy

    validates :email, presence: true, uniqueness: { scope: :shop_id }
    validates :first_name, presence: true
    validates :last_name, presence: true

  end
end
