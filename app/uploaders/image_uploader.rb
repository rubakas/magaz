# encoding: utf-8
class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  include CarrierWave::MimeTypes

  # def store_dir
  #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  # end

  def root
    "#{Rails.root}/public"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  version :extra_small do
    process :resize_to_fill => [50, 50]
  end

  version :thumb do
    process :resize_to_fill => [200, 200]
  end
end
