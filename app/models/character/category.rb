class Character::Category
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :title
  slug  :title
  field :_position, type: Float, default: 0.0

  # Validations
  validates :title, presence: true, uniqueness: true

  # Relations
  has_many :posts, :class_name => 'Character::Post'

  # Scope
  default_scope order_by(:_position => :desc)

  # Indexes
  index :slug rescue index slug: 1
end