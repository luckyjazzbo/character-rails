#= require_self
#= require_tree ./models
#= require_tree ./views


class Pages extends Character.App
  constructor: (@scope='pages', @menu='Pages') ->
    @router         = workspace.router
    
    @add_routes()
    @add_menu_item()


  fetch_data: (callback) ->
    @pages = new Character.Pages.Pages()
    @pages.fetch success: ->
      callback()


  action_index: ->
    workspace.set_current_view -> new Character.Pages.Views.PagesIndex()


  action_new: ->
    workspace.set_current_view -> new Character.Pages.Views.PagesEdit()


  action_edit: (id) ->
    page = @pages.get(id)
    workspace.set_current_view -> new Character.Pages.Views.PagesEdit model: page


Character.Pages = Pages

Character.Pages.Views  = {}






