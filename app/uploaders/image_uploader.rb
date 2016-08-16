# encoding: utf-8
class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  include CarrierWave::MimeTypes

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  version :extra_small do
    puts "********************************"
    puts "extra_small"
    process :resize_to_fill => [50, 50]
  end

  version :thumb do
    process :resize_to_fill => [200, 200]
  end
end
