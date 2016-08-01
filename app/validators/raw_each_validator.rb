class RawEachValidator < ActiveModel::EachValidator

  def validate(record)
    attributes.each do |attribute|
      raw_value = record.send("#{attribute}_before_type_cast") || record.read_attribute_for_validation(attribute)
      self.validate_each(record, attribute, raw_value)
    end
  end

end
