class Character::Image
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :image, Character::ImageUploader
  has_one :post, class_name: 'Character::Post'
  has_one :page, class_name: 'Character::Page'
end