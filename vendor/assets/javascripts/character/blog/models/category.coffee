class Category extends Backbone.Model
  #id
  #title
  #slug
  #_position

  idAttribute: '_id'


class Categories extends Backbone.Collection
  model: Category
  url: '/admin/api/Character-Category'


Character.Blog.Category   = Category
Character.Blog.Categories = Categories

