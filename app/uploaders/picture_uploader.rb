# encoding: utf-8

class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.gif"].compact.join('_'))
  end

  version :super_big_thumb do
    process :resize_to_fit => [502, 350]
  end

  version :medium_thumb do
    process :resize_to_fill => [100, 100]
  end

  version :big_thumb do
    process :resize_to_limit => [330, 250]
  end

  version :small_thumb do
    process :resize_to_fill => [40, 40]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
