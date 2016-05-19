require 'carrierwave'
require 'carrierwave/orm/activerecord'

if Rails.env.test? || Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end

  # make sure our uploader is auto-loaded
  FileUploader
  ImageUploader

  # use different dirs when testing
  # CarrierWave::Uploader::Base.descendants.each do |klass|
  #   next if klass.anonymous?
  #   klass.class_eval do
  #     def url
  #       ActionController::Base.helpers.asset_path("uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}")
  #     end

  #     # def store_dir
  #     #   "#{Rails.root}/tmp/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  #     # end
  #     def store_dir
  #       "#{Rails.root}/public/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  #       #"#{Rails.root}/public/uploads/storage"
  #     end
  #   end
  # end
end