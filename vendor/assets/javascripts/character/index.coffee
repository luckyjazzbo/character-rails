#= require jquery
#= require jquery_ujs
#= require jquery.ui.sortable
#= require jquery.ui.datepicker

#= require ./_lib/replace_nth_occurrence
#= require ./_lib/jquery.smartresize
#= require ./_lib/jquery.form

#= require ./_lib/lodash
#= require ./_lib/underscore.string
#= require ./_lib/backbone

#= require ./_lib/showdown
#= require ./_lib/showdown.image_uploader
#= require ./_lib/showdown.github
#= require ./_lib/showdown.video

# require foundation

#= require codemirror
#= require codemirror/modes/javascript
#= require codemirror/modes/css
#= require codemirror/modes/xml
#= require codemirror/modes/htmlmixed
#= require codemirror/modes/markdown

#= require redactor
#= require browserid

#= require_self

#= require ./blog
#= require ./pages


class CharacterWorkspace
  constructor: ->
    @current_view = null
    @router       = new Backbone.Router()
  
  authenticity_token: ->
    $('meta[name=csrf-token]').attr('content')

  current_view_is: (class_name) ->
    (@current_view and @current_view.constructor.name == class_name)

  set_current_view: (view_function) ->
    (@current_view.remove() ; delete @current_view) if @current_view
    @current_view = view_function()


window.Character = CharacterWorkspace


class AppSkeleton
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


window.Character.AppSkeleton = AppSkeleton



