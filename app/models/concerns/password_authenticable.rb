module Concerns
  module PasswordAuthenticable
    extend ActiveSupport::Concern

    EMAIL_VALID_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

    included do
      attr_accessor :password

      validates :email, presence: true,
                        uniqueness: true,
                        format: { with: EMAIL_VALID_REGEX }
      validates :password, presence: { on: :create }

      before_save :update_encrypted_password
    end

    def authentic_password?(password)
      self.password_digest == encrypt_password_with_salt(password, self.password_salt)
    end

    private

    def update_encrypted_password
      return if password.nil?

      self.password_salt = BCrypt::Engine.generate_salt
      self.password_digest = encrypt_password_with_salt(password, password_salt)
    end

    def encrypt_password_with_salt(password, salt)
      BCrypt::Engine.hash_secret(password, salt)
    end
  end
end
