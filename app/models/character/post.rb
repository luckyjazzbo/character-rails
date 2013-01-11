class Character::Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title
  field :published, type: Boolean, default: false
  field :date, type: Date
  field :slug
  field :md
  field :html
  field :views, type: Integer, default: 0
  field :excerpt, default: ''
  field :tags, default: ''

  #featured_image
  #category

  default_scope order_by date: :desc

  scope :drafts,    where(published: false)
  scope :published, where(published: true)
end