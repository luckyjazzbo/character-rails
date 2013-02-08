#= require_self
#= require_tree ./models
#= require_tree ./views


class Blog extends Character.App
  scope: 'blog'
  menu:  'Blog'

  constructor: (options={}) ->
    @index_scroll_y = 0
    @options        = @override_default_options(options)
    @router         = workspace.router
    
    @add_routes()
    @add_menu_item()


  override_default_options: (options) ->
    _({
        blog_url:       'http://this-is-blog.com/',
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
    if workspace.current_view_is('blog')
      workspace.current_view.close_preview()
    else
      index_view = new Character.Blog.Views.BlogIndex()
      workspace.set_current_view(index_view)


  action_new: ->
    edit_view = new Character.Blog.Views.BlogEdit()
    workspace.set_current_view(edit_view)


  action_edit: (id) ->
    post = @posts.get(id)
    edit_view = new Character.Blog.Views.BlogEdit model: post
    workspace.set_current_view(edit_view)


  action_show: (id) ->
    if not workspace.current_view_is('blog')
      @action_index()
    workspace.current_view.show_preview(id)


Character.Blog = Blog


Character.Blog.Views  = {}




