class CharacterWorkspace
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
    data_ready = _.after (_.keys(@apps)).length, ->
      Backbone.history.start()

    (app.fetch_data -> data_ready()) for app in _.values(@apps)


window.Character = CharacterWorkspace



