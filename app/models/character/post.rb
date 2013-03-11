# encoding: UTF-8

class Character::Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
  include Character::Admin

  field :title
  field :excerpt,                   default: ''
  field :published, type: Boolean,  default: false
  field :featured,  type: Boolean,  default: false
  field :date,      type: Date
  field :slug
  field :md
  field :html
  field :views,     type: Integer,  default: 0
  field :tags,                      default: ''


  # Relations
  belongs_to :featured_image, class_name:'Character::Image'
  belongs_to :category,       class_name:'Character::Category'


  # Scope
  default_scope     order_by(:published.asc, :featured.desc, :date.desc)
  scope :drafts,    where(published: false)
  scope :published, where(published: true)
  scope :featured,  where(featured: true)


  # Indexes
  index :slug rescue index slug: 1


  # Search
  search_in :title, :excerpt, :tags, :md #, html clear text should be added here

  def admin_thumb_url
    featured_image.try(:thumb)
  end

  def featured_image_url
    featured_image.try(:featured)
  end

  def self.admin_json_methods
    admin_item_options.values + %w( featured_image_url )
  end

end