#= require_self

#= require_tree ./models
#= require_tree ./views

#= require jquery_nested_form


Character.Generic = {}



#      ###    ########  ########  
#     ## ##   ##     ## ##     ## 
#    ##   ##  ##     ## ##     ## 
#   ##     ## ########  ########  
#   ######### ##        ##        
#   ##     ## ##        ##        
#   ##     ## ##        ##        



class App
  add_menu_item: ->
    html = """<li class='#{ @options.scope }'><a href='#/#{ @options.scope }'>#{ @options.menu }</a></li>"""
    $('#main_menu').append html


  select_menu: ->
    $('#main_menu li').removeClass 'active'
    $("#main_menu a[href='#/#{ @options.scope }']").parent().addClass 'active'


  before_all: (callback) ->
    @select_menu()
    callback()


  add_routes: ->

    # Index / Search / Pagination (later add Scopes)

    index_route = "#{ @options.scope }(/search/:query)(/p:page)"

    if @action_index
      @router.route index_route, "#{ @options.scope }_index", (query, page) => @before_all =>
        @action_index(page, query)

    # New

    if @action_new
      @router.route "#{ index_route }/new", "#{ @options.scope }_new", (query, page) => @before_all =>
        @action_index(page, query, => @action_new() )
    
    # Edit

    if @action_edit
      @router.route "#{ index_route }/edit/:id", "#{ @options.scope }_edit", (query, page, id) => @before_all =>
        @action_index(page, query, => @action_edit(id) )
    
    # Show

    if @action_show
      @router.route "#{ index_route }/show/:id", "#{ @options.scope }_show", (query, page, id) => @before_all =>
        @action_index(page, query, => @action_show(id) )


  constructor: (@options) ->
    @router = workspace.router
    scope   = @options.scope ? _.string.slugify(@options.title)
    menu    = @options.menu  ? @options.title
    
    _.extend @options,
      menu:               menu
      scope:              scope
      model_slug:         @options.model_name.replace('::', '-')
      search_query:       ''
      items:              => @collection.toArray()
      collection:         => @collection
      current_index_path: =>
        page   = @collection.paginate.page
        query  = @collection.search_query
        url  = "#/#{ scope }"
        url += "/search/#{ query }" if query != ""
        url += "/p#{ page }" if page > 1
        return url


    @add_routes()
    @add_menu_item()
    
    @collection           = new Character.Generic.Collection()
    @collection.url       = "/admin/api/#{ @options.model_slug }"
    @collection.paginate  = { page: 1 } if @options.paginate


  update_index_check: (page, search_query)->
    # do not update index view if
    #  - view is already on the screen AND
    #  - we are on the same collection page AND
    #  - having same search query

    return true unless workspace.current_view_is(@options.scope, 'IndexView')
    return true unless page         == parseInt(@collection.paginate.page)
    return true unless search_query == @collection.search_query

    return false


  action_index: (page=1, search_query="", callback) ->
    page = parseInt(page)

    if @update_index_check(page, search_query)
      @collection.search_query  = search_query
      @collection.paginate.page = page

      unless workspace.current_view_is(@options.scope, 'IndexView')
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
      @set_edit_view new Character.FormView(@options, workspace.current_view.el, form_html)


  action_edit: (id) ->
    @index_view.set_active(id)

    doc = @collection.get(id)
    
    config_with_model = { model: doc }
    _.extend(config_with_model, @options)

    $.get "/admin/api/#{ @options.model_slug }/#{ id }/edit", (form_html) =>
      @set_edit_view new Character.FormView(config_with_model, workspace.current_view.el, form_html)


  set_edit_view: (view) ->
    if @edit_view then (@edit_view.remove() ; delete @edit_view)
    @edit_view = view


Character.Generic.App = App





