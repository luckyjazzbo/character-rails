#= require_self




#   ##     ##  #######  ########  ######## ##       
#   ###   ### ##     ## ##     ## ##       ##       
#   #### #### ##     ## ##     ## ##       ##       
#   ## ### ## ##     ## ##     ## ######   ##       
#   ##     ## ##     ## ##     ## ##       ##       
#   ##     ## ##     ## ##     ## ##       ##       
#   ##     ##  #######  ########  ######## ######## 




class GenericModel extends Backbone.Model
  idAttribute:  '_id'


Character.GenericModel = GenericModel




#    ######   #######  ##       ##       ########  ######  ######## ####  #######  ##    ## 
#   ##    ## ##     ## ##       ##       ##       ##    ##    ##     ##  ##     ## ###   ## 
#   ##       ##     ## ##       ##       ##       ##          ##     ##  ##     ## ####  ## 
#   ##       ##     ## ##       ##       ######   ##          ##     ##  ##     ## ## ## ## 
#   ##       ##     ## ##       ##       ##       ##          ##     ##  ##     ## ##  #### 
#   ##    ## ##     ## ##       ##       ##       ##    ##    ##     ##  ##     ## ##   ### 
#    ######   #######  ######## ######## ########  ######     ##    ####  #######  ##    ## 




class GenericCollection extends Backbone.Collection
  model: Character.GenericModel


Character.GenericCollection = GenericCollection




#   ##     ## #### ######## ##      ##  ######  
#   ##     ##  ##  ##       ##  ##  ## ##    ## 
#   ##     ##  ##  ##       ##  ##  ## ##       
#   ##     ##  ##  ######   ##  ##  ##  ######  
#    ##   ##   ##  ##       ##  ##  ##       ## 
#     ## ##    ##  ##       ##  ##  ## ##    ## 
#      ###    #### ########  ###  ###   ######  




class GenericAppIndex extends Character.IndexView
  render_item: (model) ->
    config = { action_url: "#/#{ @scope }/edit/#{ model.id }" }    
    _.each @render_item_options, (val, key) -> config[key] = model.get(val)
    Character.Templates.IndexItem(config)


Character.GenericAppIndex = GenericAppIndex




#      ###    ########  ########  
#     ## ##   ##     ## ##     ## 
#    ##   ##  ##     ## ##     ## 
#   ##     ## ########  ########  
#   ######### ##        ##        
#   ##     ## ##        ##        
#   ##     ## ##        ##        




class GenericApp extends Character.App
  constructor: (@config) ->
    @router = workspace.router
    
    _.extend @config,
      scope:      _.string.slugify(@config.title)
      model_slug: @config.model.replace('::', '-')
      items:      => @collection.toArray()

    @add_routes(@config.scope)
    @add_menu_item(@config.title)
    
    @collection      = new Character.GenericCollection()
    @collection.url  = "/admin/api/#{ @config.model_slug }"


  fetch_data: (callback) ->
    @collection.fetch success: ->
      callback()


  action_index: ->
    index_view = new Character.GenericAppIndex(@config)
    workspace.set_current_view(index_view)


  action_new: ->
    #workspace.set_current_view -> new Character.Pages.Views.PagesEdit()


  action_edit: (id) ->
    #page = @pages.get(id)
    #workspace.set_current_view -> new Character.Pages.Views.PagesEdit model: page


Character.GenericApp = GenericApp





