#= require jquery
#= require jquery_ujs
#= require jquery.ui.sortable
#= require jquery.ui.datepicker

#= require browserid
# require foundation

#= require lodash
#= require underscore.string

#= require character/plugins/backbone
#= require character/plugins/underscore.string.slugify
#= require character/plugins/replace_nth_occurrence
#= require character/plugins/jquery.smartresize
#= require character/plugins/jquery.form
#= require character/plugins/jquery.trunk8

#= require_self
#= require character/generic
#= require character/blog
#= require character/pages



# ##      ##  #######  ########  ##    ##  ######  ########     ###     ######  ######## 
# ##  ##  ## ##     ## ##     ## ##   ##  ##    ## ##     ##   ## ##   ##    ## ##       
# ##  ##  ## ##     ## ##     ## ##  ##   ##       ##     ##  ##   ##  ##       ##       
# ##  ##  ## ##     ## ########  #####     ######  ########  ##     ## ##       ######   
# ##  ##  ## ##     ## ##   ##   ##  ##         ## ##        ######### ##       ##       
# ##  ##  ## ##     ## ##    ##  ##   ##  ##    ## ##        ##     ## ##    ## ##       
#  ###  ###   #######  ##     ## ##    ##  ######  ##        ##     ##  ######  ######## 



class CharacterWorkspace
  # allows Character apps to communicate between each other

  constructor: ->
    @current_view = null
    @router       = new Backbone.Router()
    @collections  = {}
    @apps         = {}

  
  current_view_is: (name) ->
    (@current_view and @current_view.options.scope == name)


  set_current_view: (view) ->
    (@current_view.remove() ; delete @current_view) if @current_view
    @current_view = view


  launch: ->
    Backbone.history.start()



#    ###    ########  ########  
#   ## ##   ##     ## ##     ## 
#  ##   ##  ##     ## ##     ## 
# ##     ## ########  ########  
# ######### ##        ##        
# ##     ## ##        ##        
# ##     ## ##        ##        



class CharacterApp
  # is an abstract class for building character apps

  add_menu_item: (menu) ->
    @menu = menu if menu
    
    html = """<li class='#{ @scope }'><a href='#/#{ @scope }'>#{ @menu }</a></li>"""
    $('#main_menu').append html


  select_menu: ->
    $('#main_menu li').removeClass 'active'
    $("#main_menu a[href='#/#{ @scope }']").parent().addClass 'active'


  before_all: (callback) ->
    @select_menu()
    callback()


  add_routes: (scope) ->
    @scope = scope if scope

    # Index / Search / Pagination (later add Scopes)

    index_route = "#{ @scope }(/search/:query)(/p:page)"

    if @action_index
      @router.route index_route, "#{ @scope }_index", (query, page) => @before_all =>
        @action_index(page, query)

    # New

    if @action_new
      @router.route "#{ index_route }/new", "#{ @scope }_new", (query, page) => @before_all =>
        @action_index(page, query, => @action_new() )
    
    # Edit

    if @action_edit
      @router.route "#{ index_route }/edit/:id", "#{ @scope }_edit", (query, page, id) => @before_all =>
        @action_index(page, query, => @action_edit(id) )
    
    # Show

    if @action_show
      @router.route "#{ index_route }/show/:id", "#{ @scope }_show", (query, page, id) => @before_all =>
        @action_index(page, query, => @action_show(id) )


window.Character      = CharacterWorkspace
window.Character.App  = CharacterApp



