class Character::AdminUser < Character::ModelAdmin
  include Mongoid::Document

  field :email
  #field :text

  def self.find_by_email(email)
    Character::AdminUser.where(email:email).first()
  end
end
