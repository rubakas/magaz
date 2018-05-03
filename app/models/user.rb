# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string
#  last_name       :string
#  email           :string
#  password_digest :string
#  phone           :string
#  homepage        :string
#  bio             :string
#  shop_id         :integer
#  created_at      :datetime
#  updated_at      :datetime
#  user_type       :string
#  password_salt   :string
#  account_owner   :boolean          default(FALSE)
#  permissions     :string           default([]), is an Array
#  invite_token    :string
#

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
