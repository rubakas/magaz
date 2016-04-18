class MagazCore::AdminServices::User::DeleteUser < ActiveInteraction::Base

  integer :id, :shop_id

  validates :id, :shop_id, presence: true
  validate :can_destroy?

  def execute
    @user.destroy
  end

  protected

  def can_destroy?
    errors.add(:base, I18n.t('services.delete_user.account_owner')) if account_owner?
  end

  def account_owner?
    @user = MagazCore::User.find(id)
    @user.account_owner == true || MagazCore::Shop.find(shop_id).users.count == 1
  end

end