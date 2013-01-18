#= require_self

#= require_tree ./models
#= require      ./views


#
# Pages init methods with options
#

Character.Pages = 
  options:
    app_container:  '#wrapper'

  init: ->
    app = new Character.Pages.Views.App(Character.Pages.options)

    # fetching pages
    pages = new Character.Pages.Pages()
    pages.fetch success: ->
      app.show_index()
      app.set_routes()

    # export
    Character.Pages.pages = pages
    Character.Pages.app   = app

