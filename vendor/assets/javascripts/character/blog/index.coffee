#= require_self
#= require_tree ./models
#= require_tree ./views


class Blog extends Character.AppSkeleton
  constructor: (@scope='blog', options={}) ->
    @index_scroll_y = 0
    @options        = @override_default_options(options)
    @router         = workspace.router
    
    @add_routes()
    @add_menu_item()


  override_default_options: (options) ->
    _({
        blog_url:       'http://this-is-blog.com/',
        app_container:  '#app',
        categories:     false,
      }).extend options


  fetch_data: (callback) ->
    # render app after data is fetched
    _data_is_ready = _.after 2, -> callback()

    # fetching posts
    @posts = new Character.Blog.Posts()
    @posts.fetch success: ->
      _data_is_ready()

    # fetching categories
    @categories = new Character.Blog.Categories()
    @categories.fetch success: ->
      _data_is_ready()


  action_index: ->
    if workspace.current_view_is('BlogIndex')
      workspace.current_view.close_preview()
    else
      workspace.set_current_view -> new Character.Blog.Views.BlogIndex()


  action_new: ->
    workspace.set_current_view -> new Character.Blog.Views.BlogEdit()


  action_edit: (id) ->
    post = @posts.get(id)
    workspace.set_current_view -> new Character.Blog.Views.BlogEdit model: post


  action_show: (id) ->
    if not workspace.current_view_is('BlogIndex')
      @action_index()
    workspace.current_view.show_preview(id)


Character.Blog = Blog


Character.Blog.Views  = {}




