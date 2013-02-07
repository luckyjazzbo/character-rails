class Character::AdminUser
  include Mongoid::Document
  include Character::AdminModel

  field :email

  def self.find_by_email(email)
    Character::AdminUser.where(email:email).first()
  end
end
