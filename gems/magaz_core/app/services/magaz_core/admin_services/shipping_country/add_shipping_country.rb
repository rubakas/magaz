class MagazCore::AdminServices::ShippingCountry::AddShippingCountry < ActiveInteraction::Base

  COUNTRY_LIST = YAML.load_file("#{MagazCore::Engine.root}/config/countries.yml")

  integer :shop_id
  string :tax, :name

  validate  :name_uniqueness
  validates :tax, numericality: true
  validates :tax, :name, :shop_id, presence: true
  validates :name, inclusion: COUNTRY_LIST['countries'].keys

  def execute
    shipping_country = MagazCore::Shop.find(shop_id).shipping_countries.new(inputs)

    unless shipping_country.save
      errors.merge!(shipping_country.errors)
    end

    shipping_country
  end

  private

  def country_info
    COUNTRY_LIST['countries'][self.name]
  end

  def name_uniqueness
    errors.add(:base, I18n.t('services.add_shipping_country.name_not_unique')) unless name_unique?
  end

  def name_unique?
    MagazCore::ShippingCountry.where(shop_id: shop_id, name: name).count == 0
  end

end
