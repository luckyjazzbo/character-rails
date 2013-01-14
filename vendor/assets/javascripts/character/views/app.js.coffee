############################
### CHARACTER :: AppView ###
############################

class AppView extends Backbone.View

  initialize: (@blog_url, @el) ->
    @render()
    window.index_scroll_y = 0
    @blog_url ||= 'http://default-blog-url.com/'

  
  render: ->
    html = """<div id='main'></div>"""
    $(@el).append html


  find_post: (id) ->
    window.posts.get(id)


  clear_view: ->
    (@index_view.remove()   ; delete @index_view)   if @index_view
    (@preview_view.remove() ; delete @preview_view) if @preview_view
    (@editor_view.remove()  ; delete @editor_view)  if @editor_view


  show_index: ->
    @clear_view()
    @index_view = new IndexView()
    

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
    @preview_view = new PostPreviewView model: post
    
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

    @editor_view = new EditorView model: post


window.AppView = AppView



