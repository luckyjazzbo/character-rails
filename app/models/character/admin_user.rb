class Character::AdminUser
  include Mongoid::Document

  field :email

  def self.find_by_email(email)
    Character::AdminUser.where(email:email).first()
  end
end
