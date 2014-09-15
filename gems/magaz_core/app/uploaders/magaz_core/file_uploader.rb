# encoding: utf-8
module MagazCore
  class FileUploader < CarrierWave::Uploader::Base
    include CarrierWave::RMagick
    include CarrierWave::MimeTypes

    def root
      "#{Rails.root}/public"
    end

    version :thumb, :if => :image? do
      process :resize_to_fill => [200, 200]
    end

    protected
    def image?(new_file)
      new_file.content_type.start_with? 'image'
    end
  end
end
