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
  #field :views,     type: Integer,  default: 0
  field :tags,                      default: ''


  # Relations
  belongs_to :featured_image, class_name:'Character::Image'
  #belongs_to :category,       class_name:'Character::Category'
  belongs_to :admin_user,     class_name:'Character::AdminUser'


  # Scope
  default_scope     order_by(:published.asc, :featured.desc, :date.desc)
  scope :drafts,    where(published: false)
  scope :published, where(published: true)
  scope :featured,  where(featured: true)


  # Indexes
  index :slug rescue index slug: 1


  # Search
  search_in :title, :excerpt, :tags, :md #, html clear text should be added here


  def self.tags_count
    tags = {}
    self.published.each do |p|
      p.tags.split(',').collect{ |t| t.strip }.uniq.each do |t|
        tags[t] = tags.has_key?(t) ? tags[t] + 1 : 1
      end
    end

    tags.sort_by{|k, v| -v}.map{ |k, v| { tag: k, count: v } }
  end


  def self.archive
    years = {}
    self.published.each do |p|
      if p.date
        year  = p.date.year
        month = p.date.strftime('%B')

        if years.has_key?(year)
          years[year] << month if not years[year].include?(month)
        else
          years[year] = [ month ]
        end
      end
    end

    years.map{|k, v| { year: k, months: v }}
  end


  def featured_image_url
    featured_image.try(:featured)
  end


  def admin_thumb_url
    featured_image.try(:thumb)
  end

  def author_name
    admin_user ? admin_user.name : ''
  end

  def self.admin_json_methods
    admin_item_options.values + %w( featured_image_url author_name )
  end

end



