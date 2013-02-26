class Character::Asset
  include Mongoid::Document
  include Mongoid::Timestamps
  include Character::Admin
  
  field           :title
  mount_uploader  :file, Character::FileUploader

  def url
    file.url
  end

  #
  # Class Methods
  #

  # Admin settings
  def self.admin_item_options
    { line1_left:   :title,
      line1_right:  :formatted_created_at,
      line2_left:   :url }
  end
end
