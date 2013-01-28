class Page extends Backbone.Model

  idAttribute:  '_id'

  update_attributes: [
    'title',
    'pemalink',
    'html',
    'keywords',
    'description',
    'featured_image_id' ]

  toJSON: ->
    attributes = {}
    attributes[a] = @get(a) for a in @update_attributes
    return { page: attributes }

  featured_image_url: ->
    @get('featured_image')?.src.featured.url

  thumb_image_url: ->
    @get('featured_image')?.src.thumb.url

  state: ->
    if @get('published') then 'Published' else 'Hidden'


Character.Pages.Page = Page



class Pages extends Backbone.Collection
  model: Page
  url: '/admin/api/Character-Page'


Character.Pages.Pages = Pages

