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


  # Relations
  belongs_to :featured_image, class_name:'Character::Image'
  belongs_to :category,       class_name:'Character::Category'


  # Scope
  default_scope     order_by date: :desc
  scope :drafts,    where(published: false)
  scope :published, where(published: true)


  # Indexes
  index :slug rescue index slug: 1


  def as_json(options = { })
    super((options || { }).merge({
        :methods => [:featured_image]
    }))
  end

  def featured_image_url
    featured_image.try(:featured)
  end
end