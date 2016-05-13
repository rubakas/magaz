classAdminServices::ShippingCountry::ChangeShippingCountry < ActiveInteraction::Base

  set_callback :validate, :after, -> {shipping_country}

  integer :shop_id, :id
  string :name, :tax

  validate  :name_uniqueness, if: :name_changed
  validates :tax, numericality: true
  validates :shop_id, :id, :name, :tax, presence: true
  validates :name, inclusion:ShippingCountry::COUNTRY_LIST['countries'].keys

  def shipping_country
    @shipping_country = Shop.find(shop_id).shipping_countries.find(id)    
    add_errors if errors.any?
    @shipping_country
  end

  def execute
    @shipping_country.update_attributes!(inputs.slice!(:id, :shop_id)) ||
      errors.add(:base, I18n.t('services.change_shipping_country.wrong_params'))
    @shipping_country
  end

  private

  def add_errors
    errors.full_messages.each do |msg|
      @shipping_country.errors.add(:base, msg)
    end
  end

  def name_changed
    Shop.find(shop_id).shipping_countries.find(id).name != name
  end

  def name_uniqueness
    errors.add(:base, I18n.t('services.change_shipping_country.name_not_unique')) unless name_unique?
  end

  def name_unique?
    ShippingCountry.where(shop_id: shop_id, name: name).count == 0
  end
end
