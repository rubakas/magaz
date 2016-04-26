class MagazCore::AdminServices::ShippingCountry::ChangeShippingCountry < ActiveInteraction::Base

  COUNTRY_LIST = YAML.load_file("#{MagazCore::Engine.root}/config/countries.yml")
  integer :shop_id, :id
  string :name, :tax

  validate  :name_uniqueness, if: :name_changed
  validates :tax, numericality: true
  validates :shop_id, :id, :name, :tax, presence: true
  validates :name, inclusion: COUNTRY_LIST['countries'].keys

  def execute
    shipping_country = MagazCore::Shop.find(shop_id).shipping_countries.find(id)
    shipping_country.update_attributes!(inputs.slice!(:id, :shop_id)) ||
      errors.add(:base, I18n.t('services.change_shipping_country.wrong_params'))

    shipping_country
  end

  private

  def name_changed
    MagazCore::Shop.find(shop_id).shipping_countries.find(id).name != name
  end

  def name_uniqueness
    errors.add(:base, I18n.t('services.change_shipping_country.name_not_unique')) unless name_unique?
  end

  def name_unique?
    MagazCore::ShippingCountry.where(shop_id: shop_id, name: name).count == 0
  end
end
