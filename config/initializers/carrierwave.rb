require 'carrierwave'
require 'carrierwave/orm/activerecord'

CarrierWave.configure do |config|
  if Rails.env.prodaction?
    config.fog_credentials = {
        provider:              'AWS',
        aws_access_key_id:     ENV['S3_ACCESS_KEY'],
        aws_secret_access_key: ENV['S3_SECRET_KEY'],
        region:                ENV['S3_REGION']
    }
    config.fog_directory  = ENV['S3_BUCKET']
    config.fog_public     = false                 # optional, defaults to true
    config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" } # optional, defaults to {}
    config.cache_dir = "#{Rails.root}/tmp/uploads"
    config.storage = :fog
  else
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
