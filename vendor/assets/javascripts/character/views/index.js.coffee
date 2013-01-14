##############################
### CHARACTER :: IndexView ###
##############################

class PostIndexItemView extends Backbone.View
  tagName: 'li'

  render: ->
    post            = @model.toJSON()
    id              = @model.id
    views           = if post.published then post.views else ''
    draft_or_date   = if post.published then @model.date_formatted() else @model.state()

    category = @model.category()
    category_title = if category then category.get('title') else 'Not set'

    image   = @model.featured_image()
    img_tag = if image then """<img class='featured' src='#{image}' />""" else """<i class='featured no-image general foundicon-photo'></i>"""

    html = """<a href='#/preview/#{id}'>
                #{img_tag}
                <div class='left'>
                  <span class='title'>#{post.title}</span>
                  <span class='meta'>#{category_title}</span>
                </div>
                <div class='right'>
                  <span class='date'>#{draft_or_date}</span>
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
                    <a href='#/new' title='Create new post' class='general foundicon-add-doc'></a>
                    <!--<span class='split'></span><a href='#' title='Search for post' class='general foundicon-search'></a>-->
                  </span>
                </header>
                <ul id='list' class='posts-index'></ul>
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
    # drafts go first, then published posts
    posts = window.posts.sortBy (p) -> p.get('published')

    if posts.length > 0
      @render_item(post) for post in posts
    else
      @render_items_placeholder()


  initialize: ->
    html = @render().el
    $('#main').append(html)

    @categories = new IndexCategoriesView

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





