#= require_self
#= require_tree ./models
#= require_tree ./views


Character.Generic = {}



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
      collection: => @collection


    @add_routes(@options.scope)
    @add_menu_item(@options.title)
    
    @collection           = new Character.Generic.Collection()
    @collection.url       = "/admin/api/#{ @options.model_slug }"
    @collection.paginate  = {} if @options.paginate


  close_form: ->
    @index_view.unlock_scroll()

    (@form_view.remove() ; delete @form_view) if @form_view

    @index_view.unset_active()
    @index_view.flush_scroll_y()
  

  action_index: (q) ->
    @options.search_query = q
    @index_view = new Character.IndexView(@options)
    workspace.set_current_view(@index_view)


  set_form_view: (view) ->
    if @form_view then (@form_view.remove() ; delete @form_view) else @index_view.lock_scroll()
    @form_view = view
    @index_view.scroll_top()
  

  action_new: ->
    if not workspace.current_view_is(@options.scope)
      @action_index()
    
    @index_view.unset_active()

    $.get "/admin/api/#{ @options.model_slug }/new", (form_html) =>
      @set_form_view new Character.FormView(@options, workspace.current_view.el, form_html)


  action_edit: (id) ->
    if not workspace.current_view_is(@options.scope)
      @action_index()

    @index_view.set_active(id)

    doc = @collection.get(id)
    
    config_with_model = { model: doc }
    _.extend(config_with_model, @options)

    $.get "/admin/api/#{ @options.model_slug }/#{ id }/edit", (form_html) =>
      @set_form_view new Character.FormView(config_with_model, workspace.current_view.el, form_html)


Character.Generic.App = App





