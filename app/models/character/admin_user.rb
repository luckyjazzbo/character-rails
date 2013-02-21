class Character::AdminUser
  include Mongoid::Document
  include Mongoid::Timestamps
  include Character::Admin
  
  field :email


  def avatar_url(size)
    hash = Digest::MD5.hexdigest(email)
    "http://www.gravatar.com/avatar/#{ hash}?s=#{ size }&d=mm"
  end


  def admin_thumb_url
    avatar_url(56)
  end

  #
  # Class Methods
  #

  def self.find_by_email(email)
    Character::AdminUser.where(email:email).first()
  end

  # Admin settings

  def self.admin_title
    "Admins"
  end

  def self.admin_render_item_options
    """{ line1_left: 'email', line2_left: 'formatted_created_at', image_url: 'admin_thumb_url' }"""
  end
end
