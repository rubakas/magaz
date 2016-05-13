class AdminServices::ShippingRate::AddShippingRate < ActiveInteraction::Base

  set_callback :validate, :after, -> {shipping_rate}

  string :name, :shipping_price, :criteria
  string :price_from, :price_to, :weight_from, :weight_to, default: nil
  integer :shipping_country_id

  validates :name, :shipping_price, :shipping_country_id, :criteria, presence: true
  validate :valid_numerical, :price_criteria_check, :weight_criteria_check,
             :price_comparison_check, :weight_comparison_check

  def shipping_rate
    shipping_country = ShippingCountry.find(shipping_country_id)
    @shipping_rate = shipping_country.shipping_rates.new
    add_errors if errors.any?
    @shipping_rate
  end

  def execute
    unless @shipping_rate.update_attributes(inputs)
      errors.merge!(@shipping_rate.errors)
    end
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
    @inputs.slice!(:shipping_country_id, :name, :criteria).each do |key, value|
      if value =~ /^(?:[1-9]\d*|0)+(?:\.\d+)?$/m
        @inputs[key] = value.to_f
      elsif value =~ /^$/
        @inputs[key] = nil
      elsif value.nil?
        next
      else
        errors.add(key, I18n.t('services.add_shipping_rate.wrong_param'))
      end
    end
  end

  def price_criteria_check
    if @inputs[:price_from].present? && @inputs[:price_to].present? &&
         criteria == "weight" && @inputs[:weight_from].nil? && @inputs[:weight_to].nil?
      errors.add(:base, I18n.t('services.add_shipping_rate.not_correct'))
    else
      return
    end
  end

  def weight_criteria_check
    if @inputs[:weight_from].present? && @inputs[:weight_to].present? &&
         criteria == "price" && @inputs[:price_from].nil? && @inputs[:price_to].nil?
      errors.add(:base, I18n.t('services.add_shipping_rate.not_correct'))
    else
      return
    end
  end

  def price_comparison_check
    if @inputs[:price_to].present? && @inputs[:price_from].present? &&
         @inputs[:price_to] < @inputs[:price_from]
      errors.add(:base, I18n.t('services.add_shipping_rate.price_to_must_be_greater'))
    else
      return
    end
  end

  def weight_comparison_check
    if @inputs[:weight_from].present? && @inputs[:weight_to].present? &&
         @inputs[:weight_to] < @inputs[:weight_from]
      errors.add(:base, I18n.t('services.add_shipping_rate.weight_to_must_be_greater'))
    else
      return
    end
  end

end
