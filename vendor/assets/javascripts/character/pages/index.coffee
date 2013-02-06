#= require_self
#= require_tree ./models
#= require_tree ./views


class Pages extends Character.App
  scope: 'pages'
  menu:  'Pages'

  constructor: ->
    @router = workspace.router
    
    @add_routes()
    @add_menu_item()


  fetch_data: (callback) ->
    @pages = new Character.Pages.Pages()
    @pages.fetch success: ->
      callback()


  action_index: ->
    index_view = new Character.Pages.Views.PagesIndex()
    workspace.set_current_view(index_view)


  action_new: ->
    edit_view = new Character.Pages.Views.PagesEdit()
    workspace.set_current_view(edit_view)


  action_edit: (id) ->
    page = @pages.get(id)
    edit_view = new Character.Pages.Views.PagesEdit model: page
    workspace.set_current_view(edit_view)


Character.Pages = Pages

Character.Pages.Views  = {}






