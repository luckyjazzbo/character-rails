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
    scope   = _.string.slugify(@options.title)
    
    _.extend @options,
      scope:              scope
      model_slug:         @options.model_name.replace('::', '-')
      items:              => @collection.toArray()
      collection:         => @collection
      search_query:       ""
      current_index_path: =>
        page   = @collection.paginate.page
        query  = @collection.search_query
        url  = "#/#{ scope }"
        url += "/search/#{ query }" if query != ""
        url += "/p#{ page }" if page > 1
        return url


    @add_routes(@options.scope)
    @add_menu_item(@options.title)
    
    @collection           = new Character.Generic.Collection()
    @collection.url       = "/admin/api/#{ @options.model_slug }"
    @collection.paginate  = { page: 1 } if @options.paginate


  update_index_check: (page, search_query)->
    # do not update index view if
    #  - view is already on the screen AND
    #  - we are on the same collection page AND
    #  - having same search query

    return true unless workspace.current_view_is(@options.scope)
    return true unless page         == parseInt(@collection.paginate.page)
    return true unless search_query == @collection.search_query

    return false


  action_index: (page=1, search_query="", callback) ->
    page = parseInt(page)

    if @update_index_check(page, search_query)
      @collection.search_query  = search_query
      @collection.paginate.page = page

      unless workspace.current_view_is(@options.scope)
        @index_view = new Character.IndexView(@options)
        workspace.set_current_view(@index_view)

      @collection.fetch
        url: @collection.paginate_url()
        success: -> callback() if callback
    else
      callback() if callback


  action_new: ->
    @index_view.unset_active()

    $.get "/admin/api/#{ @options.model_slug }/new", (form_html) =>
      @set_form_view new Character.FormView(@options, workspace.current_view.el, form_html)


  action_edit: (id) ->
    @index_view.set_active(id)

    doc = @collection.get(id)
    
    config_with_model = { model: doc }
    _.extend(config_with_model, @options)

    $.get "/admin/api/#{ @options.model_slug }/#{ id }/edit", (form_html) =>
      @set_form_view new Character.FormView(config_with_model, workspace.current_view.el, form_html)


  set_form_view: (view) ->
    if @form_view then (@form_view.remove() ; delete @form_view) else @index_view.lock_scroll()
    @form_view = view
    @index_view.scroll_top()  


Character.Generic.App = App





