class Character::AdminUser < Character::ModelAdmin
  include Mongoid::Document

  field :email

  def self.find_by_email(email)
    Character::AdminUser.where(email:email).first()
  end

  #
  # Admin Settings
  #

  def self.admin_title
    "Admins"
  end
end
