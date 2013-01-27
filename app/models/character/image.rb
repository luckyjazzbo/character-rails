class Character::Image
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :src, Character::ImageUploader
  has_one :post, class_name: 'Character::Post'
  has_one :page, class_name: 'Character::Page'


  def image
    src.url
  end

  def common
    src.common.url
  end

  def featured
    src.featured.url
  end
  
  def thumb
    src.thumb.url
  end

  def filelink
    image
  end


  def as_json(options = {})
    super((options || {}).merge({
      :methods => %w( thumb image common featured filelink )
    }))
  end
end