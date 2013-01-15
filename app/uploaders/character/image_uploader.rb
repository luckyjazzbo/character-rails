class Character::ImageUploader < BaseUploader
  version :character_thumb do
    process resize_to_fill: [56, 56]
  end

  version :regular do
    # resize by width here: 600
    process resize_to_fill: [600, 400]
  end
end