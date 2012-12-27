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

  idAttribute: '_id'


  date_formatted: ->
    date = @get('date')
    if date then date.replace(/-/g, '/') else "Date Not Set"


  featured_image: ->
    image_url = @get('featured_image_url')
    if image_url then image_url else '/no-featured-image.jpg'
  

  state: ->
    if @get('published')
      "Published"
    else "Draft"


  @slugify: (text) ->
    _.string.slugify(text)


class Posts extends Backbone.Collection
  model: Post
  url: '/admin/character/posts'

window.Posts  = Posts
window.Post   = Post