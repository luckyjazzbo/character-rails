#= require_self


Character.Generic = {}


#   ##     ##  #######  ########  ######## ##       
#   ###   ### ##     ## ##     ## ##       ##       
#   #### #### ##     ## ##     ## ##       ##       
#   ## ### ## ##     ## ##     ## ######   ##       
#   ##     ## ##     ## ##     ## ##       ##       
#   ##     ## ##     ## ##     ## ##       ##       
#   ##     ##  #######  ########  ######## ######## 




class Model extends Backbone.Model
  idAttribute:  '_id'


Character.Generic.Model = Model




#    ######   #######  ##       ##       ########  ######  ######## ####  #######  ##    ## 
#   ##    ## ##     ## ##       ##       ##       ##    ##    ##     ##  ##     ## ###   ## 
#   ##       ##     ## ##       ##       ##       ##          ##     ##  ##     ## ####  ## 
#   ##       ##     ## ##       ##       ######   ##          ##     ##  ##     ## ## ## ## 
#   ##       ##     ## ##       ##       ##       ##          ##     ##  ##     ## ##  #### 
#   ##    ## ##     ## ##       ##       ##       ##    ##    ##     ##  ##     ## ##   ### 
#    ######   #######  ######## ######## ########  ######     ##    ####  #######  ##    ## 




class Collection extends Backbone.Collection
  model: Character.Generic.Model


Character.Generic.Collection = Collection





#      ###    ########  ########  
#     ## ##   ##     ## ##     ## 
#    ##   ##  ##     ## ##     ## 
#   ##     ## ########  ########  
#   ######### ##        ##        
#   ##     ## ##        ##        
#   ##     ## ##        ##        




class App extends Character.App
  constructor: (@options) ->
    @router = workspace.router
    
    _.extend @options,
      scope:      _.string.slugify(@options.title)
      model_slug: @options.model_name.replace('::', '-')
      items:      => @collection.toArray()

    @add_routes(@options.scope)
    @add_menu_item(@options.title)
    
    @collection      = new Character.Generic.Collection()
    @collection.url  = "/admin/api/#{ @options.model_slug }"


  fetch_data: (callback) ->
    @collection.fetch success: ->
      callback()


  action_index: ->
    index_view = new Character.IndexView(@options)
    workspace.set_current_view(index_view)


  action_new: ->
    if not (workspace.current_view and workspace.current_view.model_name == @options.model_model)
      @action_index()
    
    $.get "/admin/api/#{ @options.model_slug }/new", (form_html) =>
      new Character.FormView(@options, workspace.current_view.el, form_html)


  action_edit: (id) ->
    if not (workspace.current_view and workspace.current_view.options.model_name == @options.model_model)
      @action_index()

    doc = @collection.get(id)
    
    config_with_model = { model: doc }
    _.extend(config_with_model, @options)

    $.get "/admin/api/#{ @options.model_slug }/#{ id }/edit", (form_html) ->
      new Character.FormView(config_with_model, workspace.current_view.el, form_html)


Character.Generic.App = App





