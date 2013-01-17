#= require_self

#= require ./posts
#= require ./editor


Character.Blog.Views = {}


#
# Base view with shared methods
#

class Base extends Backbone.View
  posts: ->
    Character.Blog.posts

  categories: ->
    Character.Blog.categories

  app: ->
    Character.Blog.app

  router: ->
    Character.Blog.app.router


Character.Blog.Views.Base = Base


#
# App view
#

class App extends Base

  initialize: (@blog_url, @el) ->
    @render()
    window.index_scroll_y = 0

  
  render: ->
    html = """<div id='main'></div>"""
    $(@el).append html


  find_post: (id) ->
    @posts().get(id)


  clear_view: ->
    (@index_view.remove()   ; delete @index_view)   if @index_view
    (@preview_view.remove() ; delete @preview_view) if @preview_view
    (@editor_view.remove()  ; delete @editor_view)  if @editor_view


  show_index: ->
    @clear_view()
    @index_view = new Character.Blog.Views.Posts.List()
    

  show_preview: (post_id) ->
    if @editor_view
      @clear_view()
      @show_index()

    @index_view.set_active(post_id)

    if not @preview_view
      @index_view.lock()

    # render preview
    @preview_view.remove() if @preview_view
    
    post = @find_post(post_id)
    @preview_view = new Character.Blog.Views.Posts.Preview model: post
    
    html = @preview_view.render().el
    
    $('#main').append(html)

    window.scroll(0, 0)


  close_preview: ->
    @index_view.unlock()

    # hide preview
    if @preview_view
      @preview_view.remove()
      delete @preview_view

    @index_view.unset_active()
    window.index_scroll_y = 0


  show_editor: (post_id) ->
    @clear_view()

    post = if post_id then @find_post(post_id) else null

    @editor_view = new Character.Blog.Views.Editor.Editor model: post


  set_routes: ->
    Router = Backbone.Router.extend
      routes:
        'new':          'newPost'
        'edit/:id':     'editPost'
        'preview/:id':  'showPostPreview'
        '':             'showIndex'

    @router = new Router

    @router.on 'route:newPost', =>
      @show_editor()

    @router.on 'route:editPost', (id) =>
      @show_editor(id)

    @router.on 'route:showPostPreview', (id) =>
      @show_preview(id)

    @router.on 'route:showIndex', (id) =>
      if @preview_view
        @close_preview()
      else
        @show_index()

    # Start Backbone history a necessary step for bookmarkable URL's
    Backbone.history.start()


Character.Blog.Views.App = App





