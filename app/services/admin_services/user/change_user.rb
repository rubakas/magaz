class AdminServices::User::ChangeUser < ActiveInteraction::Base

  set_callback :validate, :after, -> {user}

  integer :id, :shop_id
  string :first_name, :last_name, :email, :password
  array :permissions, default: nil

  validates :id, :shop_id, :email, :first_name, :last_name, presence: true
  validate :email_uniqueness, if: :email_changed?

  def user
    @user = Shop.find(shop_id).users.find(id)
    add_errors if errors.any?
    @user
  end

  def execute
    @user.update_attributes!(inputs.slice!(:id)) ||
      errors.add(:base, I18n.t('services.change_user.wrong_params'))
    @user
  end

  private

  def add_errors
    errors.full_messages.each do |msg|
      @user.errors.add(:base, msg)
    end
  end

  def email_changed?
    User.find(id).email != email
  end

  def email_uniqueness
    errors.add(:base, I18n.t('services.change_user.email_not_valid')) unless valid_email?
  end

  def valid_email?
    email.present? &&
      (email =~ Concerns::PasswordAuthenticable::EMAIL_VALID_REGEX) &&
        User.where(shop_id: shop_id, email: email).count == 0
  end

end
