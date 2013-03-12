class Character::Page
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Reorder
  include Character::Admin

  field :menu
  field :permalink

  field :title
  field :description
  field :keywords

  field :published, type: Boolean, default: true
  field :html

  # Relations
  belongs_to :featured_image, class_name:'Character::Image'

  # Indexes
  index({ permalink: 1}, { unique: true })

  # Scope
  scope :published, where(published: true)
  scope :hidden,    where(published: false)


  def featured_image_url
    featured_image.try(:featured)
  end


  def admin_thumb_url
    featured_image.try(:thumb)
  end


  def self.admin_json_methods
    admin_item_options.values + %w( featured_image_url )
  end
end