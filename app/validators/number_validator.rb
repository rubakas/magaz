class NumberValidator < RawEachValidator

  def validate_each(record, attribute, value)
    return if value.class == Fixnum || value =~ /^(?:[1-9]\d*|0)+(?:\.\d+)?$/m || value.blank? && options[:allow_blank]
    record.errors[attribute] << (options[:message] || I18n.t('services.add_shipping_rate.wrong_param'))
  end
end
