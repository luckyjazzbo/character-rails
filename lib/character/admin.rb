module Character::Admin
  extend ActiveSupport::Concern


  def admin_form_config
    slug  = self.class.name.gsub('::', '-')
    url   = "/admin/api/#{ slug }"

    if self.persisted?
      url += "/#{ self.id }"
    end

    { fields: self.class.admin_editable_fields,
      url: url }
  end


  included do
  end


  module ClassMethods
    def admin_editable_fields
      self.fields.keys - %w( _id _type created_at updated_at _position )
    end


    def admin_title
      self.name.split('::').last().pluralize.scan(/[A-Z][^A-Z]*/).join(' ')
    end


    def admin_reorderable?
      fields.keys.include?('_position') ? true : false
    end


    def admin_render_item_options
      fields = admin_editable_fields
      

      # add timestamp check: , line1_right:  'created_at' }"
      js = "{ line1_left:  '#{ fields[0] }' }"
      
      if fields.size > 1
        js = js.gsub(" }", ", line2_left: '#{ fields[1] }' }")
      end

      return js.html_safe
    end    
  end
end