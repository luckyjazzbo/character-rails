class CharacterApp
  add_menu_item: ->
    html = """<li><a href='#/#{ @scope }'>#{ @menu }</a></li>"""
    $('#main_menu').append html

  add_routes: ->
    if @action_index
      @router.route "#{ @scope }",          "#{ @scope }_index",     => @action_index()
    if @action_new
      @router.route "#{ @scope }/new",      "#{ @scope }_new",       => @action_new()
    if @action_edit
      @router.route "#{ @scope }/edit/:id", "#{ @scope }_edit", (id) => @action_edit(id)
    if @action_show
      @router.route "#{ @scope }/show/:id", "#{ @scope }_show", (id) => @action_show(id)


window.Character.App = CharacterApp