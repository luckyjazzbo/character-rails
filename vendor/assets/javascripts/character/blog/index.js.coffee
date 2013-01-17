#= require_self

#= require_tree ./models
#= require      ./views


#
# Blog init methods with options
#

Character.Blog = 
  options:
    blog_url:       'http://this-is-blog.com/'
    app_container:  '#wrapper'
    edit_mode:      'markdown'
    categories:     false

  init: ->
    app = new Character.Blog.Views.App(Character.Blog.options)

    # render app after data is fetched
    _data_is_ready = _.after 2, ->
      app.show_index()
      app.set_routes()

    # fetching posts
    posts = new Character.Blog.Posts()
    posts.fetch success: ->
      _data_is_ready()

    # fetching categories
    categories = new Character.Blog.Categories()
    categories.fetch success: ->
      _data_is_ready()

    # export
    Character.Blog.posts      = posts
    Character.Blog.categories = categories
    Character.Blog.app        = app

