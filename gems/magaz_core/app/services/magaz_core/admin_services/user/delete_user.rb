class MagazCore::AdminServices::User::DeleteUser < ActiveInteraction::Base

  integer :id, :shop_id

  validates :id, :shop_id, presence: true
  validate :can_destroy?

  def execute
    MagazCore::User.find(id).destroy
  end

  protected 

  def can_destroy?
    errors.add(:base, I18n.t('default.services.delete_user.account_owner')) if account_owner?
  end

  def account_owner?
    user = MagazCore::User.find(id)
    shop = MagazCore::Shop.find(shop_id)
    user.account_owner == true || shop.users.count == 1
  end

end