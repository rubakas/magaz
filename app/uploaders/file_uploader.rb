# encoding: utf-8

class FileUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  include CarrierWave::MimeTypes

  process :save_size_in_model

  version :thumb, :if => :image? do
    process :resize_to_fill => [200, 200]
  end

  version :extra_small, :if => :image? do
    process :resize_to_fill => [50, 50]
  end

  protected

  def save_size_in_model
    model.file_size = file.size
  end

  def image?(new_file)
    new_file.content_type.start_with? 'image'
  end
end
