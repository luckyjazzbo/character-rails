class Character::ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  def store_dir
    "uploads/#{ model.class.to_s.underscore }/#{ mounted_as }/#{ model.id }"
  end

  #def default_url
  #  "/assets/no-image.jpg"
  #end

  version :thumb do
    process resize_to_fill: [56, 56]
  end

  version :common do
    process resize_to_fit: [600, 10000]
  end

  version :featured do
    process resize_to_fill: [600, 400]
  end
end
