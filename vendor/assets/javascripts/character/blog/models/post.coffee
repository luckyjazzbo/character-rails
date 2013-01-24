class Post extends Backbone.Model
  #id
  #title
  #category
  #featured_image_id
  #html
  #md
  #date
  #views
  #published
  #tags
  #category_id
  #excerpt

  idAttribute: '_id'

  featured_image_url: ->
    @get('featured_image')?.image.featured.url

  thumb_image_url: -> 
    @get('featured_image')?.image.character_thumb.url


  category: ->
    Character.Blog.categories.find (c) => c.id == @get('category_id')


  date_formatted: ->
    date = @get('date')
    if date then date.replace(/-/g, '/') else 'Date Not Set'


  state: ->
    if @get('published') then 'Published' else 'Draft'


  @slugify: (text) ->
    _.string.slugify(text)


class Posts extends Backbone.Collection
  model: Post
  url: '/admin/character/posts'


Character.Blog.Posts  = Posts
Character.Blog.Post   = Post

