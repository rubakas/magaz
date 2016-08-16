require 'carrierwave'
require 'carrierwave/orm/activerecord'

if Rails.env.test? || Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end

# make sure our uploader is auto-loaded
FileUploader
ImageUploader

# use different dirs when testing
CarrierWave::Uploader::Base.descendants.map do |klass|
  next if klass.anonymous?
  klass.class_eval do
    def store_dir
      if Rails.env.test?
        "#{Rails.root}/test/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      else
        "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      end
    end
  end
end
