class AdminServices::ShippingCountry::AddShippingCountry < ActiveInteraction::Base

  set_callback :validate, :after, -> {shipping_country}

  integer :shop_id
  string :tax, :name

  validate  :name_uniqueness
  validates :tax, numericality: true
  validates :tax, :name, :shop_id, presence: true
  validates :name, inclusion: ShippingCountry::COUNTRY_LIST['countries'].keys

  def shipping_country
    @shipping_country = ShippingCountry.new    
    add_errors if errors.any?
    @shipping_country
  end

  def execute
    unless @shipping_country.update_attributes(inputs)
      errors.merge!(@shipping_country.errors)
    end
    @shipping_country
  end

  private

  def add_errors
    errors.full_messages.each do |msg|
      @shipping_country.errors.add(:base, msg)
    end
  end

  def name_uniqueness
    errors.add(:base, I18n.t('services.add_shipping_country.name_not_unique')) unless name_unique?
  end

  def name_unique?
    ShippingCountry.where(shop_id: shop_id, name: name).count == 0
  end
end
