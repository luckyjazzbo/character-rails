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

  toJSON: ->
    return { page: _.clone( @attributes ) }

  featured_image_url: ->
    @get('featured_image')?.src.featured.url

  thumb_image_url: ->
    @get('featured_image')?.src.thumb.url

  state: ->
    if @get('published') then 'Published' else 'Hidden'


Character.Pages.Page   = Page



class Pages extends Backbone.Collection
  model: Page
  url: '/admin/api/Character-Page'


Character.Pages.Pages  = Pages

