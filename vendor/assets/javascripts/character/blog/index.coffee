#= require_self
#= require_tree ./models
#= require_tree ./views

#= require codemirror
#= require codemirror/modes/javascript
#= require codemirror/modes/css
#= require codemirror/modes/xml
#= require codemirror/modes/htmlmixed
#= require codemirror/modes/markdown
#= require ./plugins/showdown


class Blog extends Character.Generic.App
  constructor: (@options) ->
    super @options
    @options.render_item_options.action_name = 'show'
    @collection.model = Character.Blog.Post

    index_route = "#{ @options.scope }(/search/:query)(/p:page)"
    @router.route "#{ index_route }/new", "#{ @options.scope }_new", (query, page) =>
      @action_new()


  action_new: ->
    @edit_view = new Character.Blog.Views.BlogEdit(@options)
    workspace.set_current_view(@edit_view)


  action_edit: (id) ->
    post = @collection.get(id)

    config_with_model = { model: post }
    _.extend(config_with_model, @options)

    @edit_view = new Character.Blog.Views.BlogEdit(config_with_model)
    workspace.set_current_view(@edit_view)


  action_show: (id) ->
    @index_view.set_active(id)

    post = @collection.get(id)
    
    config_with_model = { model: post }
    _.extend(config_with_model, @options)

    if @show_view then (@show_view.remove() ; delete @show_view)
    @show_view = new Character.Blog.Views.BlogShow config_with_model




Character.Blog        = Blog
Character.Blog.Views  = {}




