class Page extends Backbone.Model

  idAttribute:  '_id'

  update_attributes: [
    'title',
    'pemalink',
    'html',
    'keywords',
    'description',
    'published',
    'featured_image_id' ]

  toJSON: ->
    attributes = {}
    attributes[a] = @get(a) for a in @update_attributes
    return { character_page: attributes }

Character.Pages.Page = Page


class Pages extends Backbone.Collection
  model: Page
  url: '/admin/api/Character-Page'

Character.Pages.Pages = Pages

