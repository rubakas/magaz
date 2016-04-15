class MagazCore::AdminServices::Shop::ChangeShop < ActiveInteraction::Base

  string :name

  string :address, :business_name, :city, :country,
         :meta_description, :currency, :customer_email, :phone,
         :timezone, :unit_system, :zip, :page_title, default: nil

  integer :id

  validates :id, :name, presence: true

  validate :name_uniqueness, if: :name_changed?

  def execute
    shop = MagazCore::Shop.find(id)
    shop.update_attributes!(inputs.slice!(:id)) ||
      errors.add(:base, I18n.t('services.shop_services.wrong_params'))

    shop
  end

  private

  def name_changed?
    MagazCore::Shop.find(id).name != name
  end

  def name_uniqueness
    errors.add(:base, I18n.t('services.change_shop.name_not_unique')) unless name_unique?
  end

  def name_unique?
    MagazCore::Shop.where(id: id, name: name).count == 0
  end

end