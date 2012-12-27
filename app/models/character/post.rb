class Character::Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title
  filed :published, type: Boolean, default: false
  field :date, type: Date
  field :slug
  field :md
  field :html
  field :views, type: Integer, default: 0

  #featured_image
  #category
end