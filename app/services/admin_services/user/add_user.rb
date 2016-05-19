class AdminServices::User::AddUser < ActiveInteraction::Base

  integer :shop_id
  string :first_name, :last_name, :email, :password
  array :permissions, default: nil
  boolean :account_owner, default: false

  validates :shop_id, :email, :first_name, :last_name, presence: true
  validate :check_email

  def execute
    user = User.new
    user.update_attributes!(inputs) ||
      errors.add(:base, I18n.t('services.add_user.wrong_params'))

    user
  end

  private

  def check_email
    errors.add(:base, I18n.t('services.add_user.email_not_valid')) unless email_valid?
    errors.add(:base, I18n.t('services.add_user.email_not_unique')) unless email_unique?
  end

  def email_unique?
    Shop.find_by_id(shop_id).users.find_by(email: email).nil?
  end

  def email_valid?
    email && email =~ Concerns::PasswordAuthenticable::EMAIL_VALID_REGEX
  end

end
