class Character::ImageUploader < BaseUploader
  version :character_thumb do
    process resize_to_fill: [56, 56]
  end

  version :common do
    process resize_to_fit: [600, 10000]
  end

  version :featured do
    process resize_to_fill: [600, 400]
  end
end