require 'carrierwave'
require 'carrierwave/orm/activerecord'

CarrierWave.configure do |config|
  config.fog_credentials = { 
      provider:              'AWS',
      aws_access_key_id:     ENV['S3_ACCESS_KEY'],
      aws_secret_access_key: ENV['S3_SECRET_KEY'],
      region:                'eu-central-1'
  }
  config.fog_directory  = ENV['S3_BUCKET']
  config.fog_public     = false                 # optional, defaults to true
  config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" } # optional, defaults to {}
  config.cache_dir = "#{Rails.root}/tmp/uploads"

  if Rails.env.test? || Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
  else
    config.storage = :fog
  end

end

# make sure our uploader is auto-loaded
FileUploader
ImageUploader

# use different dirs when testing
CarrierWave::Uploader::Base.descendants.each do |klass|
  next if klass.anonymous?
  klass.class_eval do
    # def url
    #   ActionController::Base.helpers.asset_path("uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}")
    # end

    # def store_dir
    #   "#{Rails.root}/tmp/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    # end
    def store_dir
      "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      #"#{Rails.root}/public/uploads/storage"
    end
  end
end