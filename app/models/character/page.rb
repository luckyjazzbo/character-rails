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
  #validates_uniqueness_of :permalink
  # need a validator for permalink with proper regex
  #validates_format_of :permalink, with: /\A\w+\Z/

  # Indexes
  index({ permalink: 1}, { unique: true })

  # Scope
  scope :published, where(published: true)
  scope :hidden,    where(published: false)

  # Facebook opengraph support

  #include Mongoid::Acts::Opengraph
  #acts_as_opengraph values: { type: "Article" }

  #def opengraph_url
  #  ENV['WEBSITE_URL'] + permalink
  #end

  def menu_title
    return menu if menu and menu != ''
    return title
  end

  def as_json(options = { })
    super((options || { }).merge({
        :methods => [:featured_image, :menu_title]
    }))
  end  

  def featured_image_url
    featured_image.try(:featured)
  end
end