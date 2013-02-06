class CharacterApp
  add_menu_item: (menu) ->
    @menu = menu if menu
    
    html = """<li><a href='#/#{ @scope }'>#{ @menu }</a></li>"""
    $('#main_menu').append html


  select_menu: ->
    $('#main_menu li').removeClass 'current'
    $("#main_menu a[href='#/#{ @scope }']").parent().addClass 'current'


  add_routes: (scope) ->
    @scope = scope if scope

    if @action_index
      @router.route "#{ @scope }",          "#{ @scope }_index",     => @select_menu(); @action_index()
    if @action_new
      @router.route "#{ @scope }/new",      "#{ @scope }_new",       => @select_menu(); @action_new()
    if @action_edit
      @router.route "#{ @scope }/edit/:id", "#{ @scope }_edit", (id) => @select_menu(); @action_edit(id)
    if @action_show
      @router.route "#{ @scope }/show/:id", "#{ @scope }_show", (id) => @select_menu(); @action_show(id)


window.Character.App = CharacterApp