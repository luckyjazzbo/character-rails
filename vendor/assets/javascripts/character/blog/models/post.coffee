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
  url: '/admin/character/posts'


Character.Blog.Posts  = Posts
Character.Blog.Post   = Post

