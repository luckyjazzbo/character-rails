#= require_self

#= require ./pages
#= require ./editor


Character.Pages.Views = {}


#
# Base view with shared methods
#

class Base extends Backbone.View
  pages: ->
    Character.Pages.pages

  app: ->
    Character.Pages.app

  router: ->
    Character.Pages.app.router


Character.Pages.Views.Base = Base


#
# App view
#

class App extends Base

  initialize: (@options) ->
    @el = @options.app_container
    @render()
    window.index_scroll_y = 0

  
  render: ->
    html = """<div id='main'></div>"""
    $(@el).append html


  find_page: (id) ->
    @pages().get(id)


  clear_view: ->
    (@index_view.remove()   ; delete @index_view)   if @index_view
    (@editor_view.remove()  ; delete @editor_view)  if @editor_view


  show_index: ->
    @clear_view()
    @index_view = new Character.Pages.Views.Pages.List()
    

  show_editor: (page_id, redactor=false) ->
    @clear_view()

    page = if page_id then @find_page(page_id) else null

    @editor_view = new Character.Pages.Views.Editor.Editor redactor: redactor, model: page


  set_routes: ->
    Router = Backbone.Router.extend
      routes:
        'new':          'newPage'
        'edit/:id':     'editPageContent'
        'source/:id':   'editPageSource'
        '':             'showPages'

    @router = new Router

    @router.on 'route:newPage', =>
      @show_editor()

    @router.on 'route:editPageContent', (id) =>
      @show_editor(id, redactor = true)

    @router.on 'route:editPageSource', (id) =>
      @show_editor(id)

    @router.on 'route:showPages', (id) =>
      @show_index()

    # Start Backbone history a necessary step for bookmarkable URL's
    Backbone.history.start()


Character.Pages.Views.App = App





