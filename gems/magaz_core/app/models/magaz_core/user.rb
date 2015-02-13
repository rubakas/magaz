module MagazCore
  class User < ActiveRecord::Base
    include Concerns::PasswordAuthenticable
    self.table_name = 'users'

    belongs_to :shop

    before_create :confirmation_token

    validates :email, presence: true, uniqueness: { scope: :shop_id }
    validates :first_name, presence: true
    validates :last_name, presence: true

    #need for confirmation
    def email_activate
      self.email_confirmed = true
      self.confirm_token = nil
      save!(:validate => false)
    end

    private

    def confirmation_token
      if self.confirm_token.blank?
        self.confirm_token = SecureRandom.urlsafe_base64.to_s
      end
    end
  end
end
