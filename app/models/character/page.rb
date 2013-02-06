class Character::Page
  include Mongoid::Document
  include Mongoid::Reorder

  field :title
  field :menu
  field :permalink
  field :published, type: Boolean, default: true

  field :html

  field :keywords
  field :description

  # Relations
  belongs_to :featured_image, class_name:'Character::Image'

  validates_presence_of :title, :permalink

  # Indexes
  index({ permalink: 1}, { unique: true })

  # Scope
  scope :published, where(published: true)
  scope :hidden,    where(published: false)


  def as_json(options = { })
    super((options || { }).merge({
        :methods => [:menu_title, :state, :featured_image_url, :thumb_image_url]
    }))
  end  

  def menu_title
    return menu if menu and menu != ''
    return title
  end

  def state
    published ? 'Published' : 'Hidden'
  end

  def featured_image_url
    featured_image.try(:featured)
  end

  def thumb_image_url
    featured_image.try(:thumb)
  end

end