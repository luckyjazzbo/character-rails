module Character::AdminModel
  extend ActiveSupport::Concern

  included do
    #field :_position, :type => Float, :default => 0.0
    #default_scope order_by(:_position => :desc)
  end

  def admin_form_config
    skip_fields = %w( _id _type created_at udpated_at _position )

    slug  = self.class.name.gsub('::', '-')
    url   = "/admin/api/#{ slug }"

    if self.persisted?
      url += "/#{ self.id }"
    end

    { fields: self.class.fields.keys - skip_fields,
      url: url }
  end

  module ClassMethods
  end
end