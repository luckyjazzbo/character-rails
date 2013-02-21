class Post extends Backbone.Model
  idAttribute:  '_id'

  update_attributes: [
    'title',
    'slug',
    'md',
    'html',
    'date',
    'tags',
    'excerpt',
    'category_id',
    'published',
    'featured_image_id',
    'featured' ]

  toJSON: ->
    attributes = {}
    attributes[a] = @get(a) for a in @update_attributes
    return { character_post: attributes }

  category: ->
    Character.Blog.categories.find (c) => c.id == @get('category_id')

Character.Blog.Post   = Post


class Posts extends Backbone.Collection
  model: Post
  url: '/admin/api/Character-Post'

Character.Blog.Posts  = Posts

