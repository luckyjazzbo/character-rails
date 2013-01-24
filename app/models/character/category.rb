class Character::Category
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Mongoid::Reorder

  field :title
  slug  :title

  # Validations
  validates :title, presence: true, uniqueness: true

  # Relations
  has_many :posts, :class_name => 'Character::Post'

  # Indexes
  index :slug rescue index slug: 1
end