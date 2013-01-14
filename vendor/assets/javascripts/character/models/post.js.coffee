class Post extends Backbone.Model
  #id
  #title
  #category
  #featured_image
  #html
  #md
  #date
  #views
  #published
  #tags
  #category_id
  #excerpt

  idAttribute: '_id'


  category: ->
    window.categories.find (c) => c.id == @get('category_id')


  date_formatted: ->
    date = @get('date')
    if date then date.replace(/-/g, '/') else 'Date Not Set'


  featured_image: ->
    @get('featured_image_url')
  

  state: ->
    if @get('published') then 'Published' else 'Draft'


  @slugify: (text) ->
    _.string.slugify(text)


class Posts extends Backbone.Collection
  model: Post
  url: '/admin/character/posts'

window.Posts  = Posts
window.Post   = Post