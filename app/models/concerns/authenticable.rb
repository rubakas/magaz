module Authenticable extend ActiveSupport::Concern
  
  included do
    attr_accessor :password

    validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
    validates :password, presence: { on: :create }
    validates :name, presence: true

    before_save :update_encrypted_password
  end

  def authentic_password?(password)
    self.password_digest == encrypt_password_with_salt(password, self.password_salt)
  end

  private

  def update_encrypted_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_digest = encrypt_password_with_salt(password, password_salt)
    end
  end

  def encrypt_password_with_salt(password, salt)
    BCrypt::Engine.hash_secret(password, salt)
  end

end