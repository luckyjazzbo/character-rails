class Category extends Backbone.Model
  #id
  #title
  #slug
  #_position

  idAttribute: '_id'


class Categories extends Backbone.Collection
  model: Category
  url: '/admin/character/categories'

window.Categories  = Categories
window.Category    = Category