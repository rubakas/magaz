class User < ActiveRecord::Base
  include Concerns::PasswordAuthenticable

  has_many    :reviews
  belongs_to  :shop
  validates :shop_id, :email, :first_name, :last_name, presence: true, on: :create_shop
  validates :email,
            uniqueness: { scope: :shop_id },
            format: { with: Concerns::PasswordAuthenticable::EMAIL_VALID_REGEX },
            on: :invite
  validate :can_destroy?, on: :destroy

  with_options({on: :invite2}) do |for_invite|
    for_invite.validates :email, uniqueness: { scope: :shop_id }
  end

  def full_name
    [self.first_name, self.last_name].map(&:capitalize).join(" ")
  end

  def destroy
    transaction do
      super() if valid?(:destroy)
    end
  end

  private

  def can_destroy?
    errors.add(:base, I18n.t('services.delete_user.account_owner')) if account_owner?
  end

  def account_owner?
    account_owner == true || shop.users.size == 1
  end
end
