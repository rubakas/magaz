# encoding: utf-8
module MagazCore
  class ImageUploader < CarrierWave::Uploader::Base
    include CarrierWave::RMagick

    # def store_dir
    #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    # end

    def root
      "#{Rails.root}/public"
    end

    version :thumb do
      process :resize_to_fill => [200, 200]
    end

  end
end