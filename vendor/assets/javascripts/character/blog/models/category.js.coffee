class Category extends Backbone.Model
  #id
  #title
  #slug
  #_position

  idAttribute: '_id'


class Categories extends Backbone.Collection
  model: Category
  url: '/admin/character/categories'

  @reorder_url: ->
    '/admin/character/categories-reorder'


Character.Blog.Category   = Category
Character.Blog.Categories = Categories

