# encoding: utf-8

class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  end

  version :thumb do
    process :resize_to_fill => [200, 100]
  end

  version :big_thumb do
    process :resize_to_limit => [330, 250]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
