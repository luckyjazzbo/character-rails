#= require ../lodash
#= require ../underscore.string
#= require ../backbone
#= require ../showdown
#= require ../jquery.smartresize

#= require_tree ./models
#= require_tree ./views
#= require_tree ./


window.set_routes = ->
  Router = Backbone.Router.extend
    routes:
      'new':          'newPost'
      'edit/:id':     'editPost'
      'preview/:id':  'showPostPreview'
      '':             'showIndex'

  router = new Router

  router.on 'route:newPost', ->
    window.app.show_editor()

  router.on 'route:editPost', (id) ->
    window.app.show_editor(id)

  router.on 'route:showPostPreview', (id) ->
    window.app.show_preview(id)

  router.on 'route:showIndex', (id) ->
    if window.app.preview_view
      window.app.close_preview()
    else
      window.app.show_index()

  window.router = router

  # Start Backbone history a necessary step for bookmarkable URL's
  Backbone.history.start()


window.initialize_character = (blog_url = 'http://this-is-blog.com/', app_container = '#wrapper') ->
  window.posts      = new Posts()
  window.categories = new Categories()

  _data_is_ready = _.after 2, ->
    window.app = new AppView(blog_url, app_container)
    window.app.show_index()
    window.set_routes()

  window.posts.fetch success: ->
    _data_is_ready()

  window.categories.fetch success: ->
    _data_is_ready()




