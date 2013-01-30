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
    'featured_image_id' ]

  toJSON: ->
    attributes = {}
    attributes[a] = @get(a) for a in @update_attributes
    return { post: attributes }

  featured_image_url: ->
    @get('featured_image')?.src.featured.url

  thumb_image_url: ->
    @get('featured_image')?.src.thumb.url

  date_formatted: ->
    date = @get('date')
    if date then date.replace(/-/g, '/') else ''

  state: ->
    if @get('published') then 'Published' else 'Draft'

  draft_or_date: ->
    if @get('published') then @date_formatted() else @state()


  category: ->
    Character.Blog.categories.find (c) => c.id == @get('category_id')


class Posts extends Backbone.Collection
  model: Post
  url: '/admin/api/Character-Post'


Character.Blog.Posts  = Posts
Character.Blog.Post   = Post

