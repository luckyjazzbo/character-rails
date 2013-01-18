class Page extends Backbone.Model
  #id
  #title
  #featured_image_id
  #html
  #views
  #published
  #keywords
  #description


  idAttribute: '_id'


  featured_image_url: ->
    @toJSON().featured_image.image.featured.url


  thumb_image_url: ->  
    @toJSON().featured_image.image.character_thumb.url


  state: ->
    if @get('published') then 'Published' else 'Hidden'


  @slugify: (text) ->
    _.string.slugify(text)


class Pages extends Backbone.Collection
  model: Page
  url: '/admin/character/pages'

  @reorder_url: ->
    '/admin/character/pages-reorder'


Character.Pages.Pages  = Pages
Character.Pages.Page   = Page

