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




#   ##     ## #### ######## ##      ##  ######  
#   ##     ##  ##  ##       ##  ##  ## ##    ## 
#   ##     ##  ##  ##       ##  ##  ## ##       
#   ##     ##  ##  ######   ##  ##  ##  ######  
#    ##   ##   ##  ##       ##  ##  ##       ## 
#     ## ##    ##  ##       ##  ##  ## ##    ## 
#      ###    #### ########  ###  ###   ######  




class IndexView extends Character.IndexView
  render_item: (model) ->
    config = { action_url: "#/#{ @scope }/edit/#{ model.id }" }    
    _.each @render_item_options, (val, key) -> config[key] = model.get(val)
    Character.Templates.IndexItem(config)


Character.Generic.IndexView = IndexView




#      ###    ########  ########  
#     ## ##   ##     ## ##     ## 
#    ##   ##  ##     ## ##     ## 
#   ##     ## ########  ########  
#   ######### ##        ##        
#   ##     ## ##        ##        
#   ##     ## ##        ##        




class App extends Character.App
  constructor: (@config) ->
    @router = workspace.router
    
    _.extend @config,
      scope:      _.string.slugify(@config.title)
      model_slug: @config.model_name.replace('::', '-')
      items:      => @collection.toArray()

    @add_routes(@config.scope)
    @add_menu_item(@config.title)
    
    @collection      = new Character.Generic.Collection()
    @collection.url  = "/admin/api/#{ @config.model_slug }"


  fetch_data: (callback) ->
    @collection.fetch success: ->
      callback()


  action_index: ->
    index_view = new Character.Generic.IndexView(@config)
    workspace.set_current_view(index_view)


  action_new: ->
    if not (workspace.current_view and workspace.current_view.model_name == @config.model_model)
      @action_index()
    
    form = new Character.FormView(@config)
    
    $.get "/admin/api/#{ @config.model_slug }/new", (form_html) ->
      html = form.render(form_html).el
      $(workspace.current_view.el).append(html)


  action_edit: (id) ->
    if not (workspace.current_view and workspace.current_view.model_name == @config.model_model)
      @action_index()

    doc = @collection.get(id)
    
    config_with_model = { model: doc }
    _.extend(config_with_model, @config)

    form = new Character.FormView(config_with_model)
    
    $.get "/admin/api/#{ @config.model_slug }/#{ id }/edit", (form_html) ->
      html = form.render(form_html).el
      $(workspace.current_view.el).append(html)


Character.Generic.App = App





