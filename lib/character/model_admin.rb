module Character
  class ModelAdmin
    def admin_form_config
      

      slug  = self.class.name.gsub('::', '-')
      url   = "/admin/api/#{ slug }"

      if self.persisted?
        url += "/#{ self.id }"
      end

      { fields: self.class.admin_editable_fields,
        url: url }
    end


    def self.admin_editable_fields
      self.fields.keys - %w( _id _type created_at udpated_at _position )
    end


    def self.admin_title
      self.name.split('::').last().pluralize
    end


    def self.admin_reorderable?
      fields.keys.include? '_position' ? true : false
    end


    def self.admin_render_item_options
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