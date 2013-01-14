class Character::Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title
  field :published, type: Boolean,  default: false
  field :date,      type: Date
  field :slug
  field :md
  field :html
  field :views,     type: Integer,  default: 0
  field :excerpt,                   default: ''
  field :tags,                      default: ''
  #featured_image

  # Relations
  belongs_to :category, :class_name => "Character::Category"

  default_scope order_by date: :desc

  # Scope
  scope :drafts,    where(published: false)
  scope :published, where(published: true)

  # Indexes
  index :slug rescue index slug: 1
end