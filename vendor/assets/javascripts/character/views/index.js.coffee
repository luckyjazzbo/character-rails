##############################
### CHARACTER :: IndexView ###
##############################

class PostIndexItemView extends Backbone.View
  tagName: 'li'

  render: ->
    post  = @model.toJSON()
    id    = @model.id
    image = @model.featured_image()
    views = if post.published then post.views else ''
    date  = @model.date_formatted()

    html = """<a href='#/preview/#{id}'>
                <img class='featured' src='#{image}' />
                <div class='left'>
                  <span class='title'>#{post.title}</span>
                  <span class='meta'>#{@model.state()}</span>
                </div>
                <div class='right'>
                  <span class='date'>#{date}</span>
                  <span class='views'>#{views}</span>
                </div>
              </a>"""
    $(this.el).html html
    return this


class IndexView extends Backbone.View
  tagName:    'div'
  className:  'chr-panel left index'
  id:         'blog_index'


  render: ->
    html = """<section class='container'>
                <header>
                  <span class='title'>Posts</span>
                  <span class='buttons'>
                    <a href='#/new' title='Create new post' class='foundicon-add-doc'></a>
                    <!--<span class='split'></span><a href='#' title='Search for post' class='foundicon-search'></a>-->
                  </span>
                </header>
                <ul id='list'></ul>
              </section>"""
    $(this.el).html html
    return this


  render_item: (post) ->
    item = new PostIndexItemView model: post
    html = item.render().el
    $(@list).append html

    @item_views[post.id] = item

  render_items_placeholder: ->
    html = """<li class='placeholder'>Hey there! You don't have any posts yet, so go ahead and create the first one!</li>"""
    $(@list).append html    

  render_items: ->
    posts = window.posts.toArray()
    if posts.length > 0
      @render_item(post) for post in posts
    else
      @render_items_placeholder()


  initialize: ->
    html = @render().el
    $('#main').append(html)

    @list        = document.getElementById('list')
    @item_views  = {}

    @render_items()


  scroll_to_active: ->
    if window.index_scroll_y > 0
      window.scroll(0, window.index_scroll_y)
    else
      top_offset = $('#blog_index a.active').offset().top
      if top_offset - window.scrollY > $(window).height()
        window.scroll(0, top_offset - 100)
  

  set_active: (id) ->
    @unset_active()
    $("#blog_index a[href='#/preview/#{id}']").addClass('active')
    @scroll_to_active()


  unset_active: ->
    $('#blog_index a.active').removeClass('active')


  lock: ->
    window.index_scroll_y = window.scrollY
    $(@el).css('top', -window.scrollY + 40).addClass('fixed') # 40 is an active admin header height


  unlock: ->
    $(@el).css('top', '').removeClass('fixed')
    window.scroll(0, window.index_scroll_y)


window.IndexView = IndexView





