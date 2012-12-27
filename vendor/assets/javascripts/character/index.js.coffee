#= require ../lodash
#= require ../underscore.string
#= require ../backbone
#= require ../showdown
#= require ../jquery.smartresize

#= require_tree ./models
#= require_tree ./views
#= require_tree ./

window.initialize_character = (blog_url = 'http://this-is-blog.com/', app_container = '#wrapper') ->
  window.seed_data()

  window.app = new AppView(blog_url, app_container)
  window.app.show_index()

  # Start Backbone history a necessary step for bookmarkable URL's
  Backbone.history.start()

