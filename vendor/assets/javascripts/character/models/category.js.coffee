class Category extends Backbone.Model
  #id
  #title
  #slug
  #_position

  idAttribute: '_id'


class Categories extends Backbone.Collection
  model: Category
  url: '/admin/character/categories'

  @reorder_url: (text) ->
    '/admin/character/categories-reorder'


window.Categories  = Categories
window.Category    = Category