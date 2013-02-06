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
        :methods => [:state, :date_formatted, :date_or_state, :featured_image_url, :thumb_image_url]
    }))
  end

  def state
    published ? 'Published' : 'Draft'
  end

  def date_formatted
    date ? date.to_s.gsub('-', '/') : ''
  end

  def date_or_state
    published ? date_formatted : state
  end

  def featured_image_url
    featured_image.try(:featured)
  end

  def thumb_image_url
    featured_image.try(:thumb)
  end

end