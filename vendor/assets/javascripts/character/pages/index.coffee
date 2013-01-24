#= require_self
#= require_tree ./models
#= require_tree ./views


class Pages extends Character.AppSkeleton
  constructor: (@scope='pages', options={}) ->
    @options        = @override_default_options(options)
    @router         = workspace.router
    
    @add_routes()
    @add_menu_item()


  override_default_options: (options) ->
    _({ app_container: '#app' }).extend options


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






