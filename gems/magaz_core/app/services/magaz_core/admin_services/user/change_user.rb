class MagazCore::AdminServices::User::ChangeUser < ActiveInteraction::Base

  integer :id
  string :first_name, :last_name, :email, :password
  array :permissions, default: nil

  validates :id, :email, :first_name, :last_name, presence: true
  validate :email_uniqueness, if: :email_changed?

  def execute
    user = MagazCore::User.find(id)
    user.update_attributes!(inputs.slice!(:id)) ||
      errors.add(:base, I18n.t('services.change_user.wrong_params'))

    user
  end

  private

  def email_changed?
    MagazCore::User.find(id).email != email
  end

  def email_uniqueness
    errors.add(:base, I18n.t('services.change_user.email_not_valid')) unless valid_email?
  end

  def valid_email?
    email.present? &&
      (email =~ MagazCore::Concerns::PasswordAuthenticable::EMAIL_VALID_REGEX) &&
        MagazCore::User.where(shop_id: MagazCore::User.find(id).shop_id, email: email).count == 0
  end

end