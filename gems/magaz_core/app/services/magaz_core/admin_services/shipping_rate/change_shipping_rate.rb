class MagazCore::AdminServices::ShippingRate::ChangeShippingRate < ActiveInteraction::Base

  set_callback :validate, :after, -> {shipping_rate}

  string :name
  string :price_from, :price_to, :weight_from, :weight_to, :criteria, default: nil
  float :shipping_price
  integer :id, :shipping_country_id

  validates :name, :shipping_price, :id, presence: true
  validate :valid_numerical, :price_criteria_check, :weight_criteria_check,
             :price_comparison_check, :weight_comparison_check

  def shipping_rate
    shipping_country = MagazCore::ShippingCountry.find(shipping_country_id)
    @shipping_rate = shipping_country.shipping_rates.find(id)
    add_errors if errors.any?
    @shipping_rate
  end

  def execute 
    @shipping_rate.update_attributes!(@inputs.slice!(:id)) || 
      errors.add(:base, I18n.t('services.change_shipping_rate.wrong_params'))
    @shipping_rate
  end

  private

  def add_errors
    errors.full_messages.each do |msg|
      @shipping_rate.errors.add(:base, msg)
    end
  end

  def valid_numerical
    @inputs = inputs
    @inputs.each do |key, value|
      if key == :price_from || key == :price_to || key == :weight_from || key == :weight_to
        if value =~ /^(?:[1-9]\d*|0)+(?:\.\d+)?$/m
          @inputs[key] = value.to_f
        elsif value =~ /^$/ 
          @inputs[key] = nil
        elsif value.nil? 
          next
        else
          @inputs[key] = nil
          errors.add(key, I18n.t('services.change_shipping_rate.wrong_param'))
        end
      end
    end
  end

  def price_criteria_check
    if @inputs[:price_from].present? && @inputs[:price_to].present? && 
         criteria == "weight" && @inputs[:weight_from].nil? && @inputs[:weight_to].nil?
      errors.add(:base, I18n.t('services.change_shipping_rate.not_correct'))
    else
      return
    end
  end

  def weight_criteria_check
    if @inputs[:weight_from].present? && @inputs[:weight_to].present? &&
         criteria == "price" && @inputs[:price_from].nil? && @inputs[:price_to].nil?
      errors.add(:base, I18n.t('services.change_shipping_rate.not_correct'))
    else
      return
    end
  end

  def price_comparison_check
    if @inputs[:price_to].present? && @inputs[:price_from].present? &&
         @inputs[:price_to] < @inputs[:price_from]
      errors.add(:base, I18n.t('services.change_shipping_rate.price_to_must_be_greater'))
    else
      return
    end
  end

  def weight_comparison_check
    if @inputs[:weight_from].present? && @inputs[:weight_to].present? &&
         @inputs[:weight_to] < @inputs[:weight_from]
      errors.add(:base, I18n.t('services.change_shipping_rate.weight_to_must_be_greater'))
    else
      return
    end
  end

end